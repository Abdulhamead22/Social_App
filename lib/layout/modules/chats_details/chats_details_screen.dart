import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/cubits/social_cubit.dart';
import 'package:flutter_application_1/layout/cubits/social_state.dart';
import 'package:flutter_application_1/layout/models/chat_model.dart';
import 'package:flutter_application_1/layout/models/social_user_model.dart';
import 'package:flutter_application_1/layout/style/icon_broken.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ChatsDetailsScreen extends StatelessWidget {
  ChatsDetailsScreen({super.key, required this.model});
  final SocialUserModel model;
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      //اعملت builder جديد عشان نا بدي ابعت حاجة قبل ما يبدأ consumer
      builder: (context) {
        SocialCubit.get(context).getmessage(model.uId);

        return BlocConsumer<SocialCubit, SocialState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Row(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            model.image,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          model.name,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).message.isNotEmpty,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            //الاثنين الي تحت عملتهم عشان انا وسط scrolView
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: SocialCubit.get(context).message.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                              height: 10,
                            ),
                            itemBuilder: (context, index) {
                              var message =
                                  SocialCubit.get(context).message[index];

                              if (model.uId == message.receiverId) {
                                return buildMymessage(context, index, message);
                              } else {
                                return buildRecivermessage(
                                    context, index, message);
                              }
                            },
                          ),
                        ),
                        buildSendBox(context),
                      ],
                    ),
                  );
                },
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  buildRecivermessage(
    context,
    index,
    ChatModel model,
  ) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            )),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          model.text,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }

  buildMymessage(context, index, ChatModel model) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            )),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          model.text,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }

  buildSendBox(context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(28)),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                controller: messageController,
                decoration: const InputDecoration(
                  hintText: 'type your message here ...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(IconBroken.Send),
            onPressed: () {
              SocialCubit.get(context).sendmessage(
                  text: messageController.text,
                  receiverId: model.uId, //ركز هادا ال id الي دخلت عليه مش تبعي
                  dateTime: DateTime.now().toString());
            },
          ),
        ],
      ),
    );
  }
}
