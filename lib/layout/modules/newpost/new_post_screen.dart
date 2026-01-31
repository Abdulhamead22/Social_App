import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/cubits/social_cubit.dart';
import 'package:flutter_application_1/layout/cubits/social_state.dart';
import 'package:flutter_application_1/layout/style/icon_broken.dart';
import 'package:flutter_application_1/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    var now = DateTime.now();
    var cubit = SocialCubit.get(context);
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            context,
            "Create Post",
            [
              defaultTextButton(
                  function: () {
                    if (cubit.postImage == null) {
                      cubit.createPost(
                          dateTime: now.toString(), text: textController.text);
                    } else {
                      cubit.uploadPostImage(
                          dateTime: now.toString(), text: textController.text);
                    }
                  },
                  text: 'POST'),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLodingState)
                  const LinearProgressIndicator(),
                if (state is SocialCreatePostLodingState)
                  const SizedBox(
                    height: 10,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        SocialCubit.get(context).userModel!.image,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        SocialCubit.get(context).userModel!.name,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      hintText: " what is on your mind ...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (cubit.postImage != null)
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(cubit.postImage!),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cubit.removePostImage();
                        },
                        icon: const CircleAvatar(
                          radius: 20,
                          child: Icon(
                            Icons.close,
                            size: 16,
                            //    color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconBroken.Image,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Add Photo'),
                          ],
                        ),
                        onPressed: () {
                          cubit.getpostImage();
                        },
                      ),
                    ),
                    Expanded(
                        child:
                            defaultTextButton(function: () {}, text: '# tags')),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
