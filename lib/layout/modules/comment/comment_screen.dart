import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/cubits/social_cubit.dart';
import 'package:flutter_application_1/layout/cubits/social_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsScreen extends StatelessWidget {
  CommentsScreen({super.key, required this.postId});
  final String postId;

  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
SocialCubit.get(context).getComments(postId);

    return Scaffold(
      appBar: AppBar(title: const Text('Comments')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: BlocConsumer<SocialCubit, SocialState>(
              builder: (context, state) {
                var comments = SocialCubit.get(context).commentNum;

                return ListView.separated(
                  //الاثنين الي تحت عملتهم عشان انا وسط scrolView
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: comments.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(comments[index]['image']),
                      ),
                      title: Text(comments[index]['name']),
                      subtitle: Text(comments[index]['comments']),
                    );
                  },
                );
              },
              listener: (context, state) {},
            ),
          ),
          buildComments(context)
        ],
      ),
    );
  }

  buildComments(context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage(
              SocialCubit.get(context).userModel!.image,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextField(
              controller: commentController,
              decoration: const InputDecoration(
                hintText: 'Write a comment...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              SocialCubit.get(context)
                  .commentPost(postId, commentController.text);
              commentController.clear();
            },
          ),
        ],
      ),
    );
  }
}
