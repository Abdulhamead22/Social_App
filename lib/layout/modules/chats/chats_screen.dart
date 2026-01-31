import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/cubits/social_cubit.dart';
import 'package:flutter_application_1/layout/cubits/social_state.dart';
import 'package:flutter_application_1/layout/models/social_user_model.dart';
import 'package:flutter_application_1/layout/modules/chats_details/chats_details_screen.dart';
import 'package:flutter_application_1/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//https://w10.mycima.cc/play.php?vid=9dfb7e61b

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).user.isNotEmpty,
          builder: (context) {
            return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return buildChat(context,SocialCubit.get(context).user[index]);
                },
                separatorBuilder: (context, index) => myDrevider(),
                itemCount: SocialCubit.get(context).user.length);
          },
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildChat(context, SocialUserModel model) {
    return InkWell(
      onTap: () {
        navigatTo(context,  ChatsDetailsScreen(model: model,));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
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
      ),
    );
  }
}
