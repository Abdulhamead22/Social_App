import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/cubits/social_cubit.dart';
import 'package:flutter_application_1/layout/cubits/social_state.dart';
import 'package:flutter_application_1/layout/models/post_model.dart';
import 'package:flutter_application_1/layout/modules/comment/comment_screen.dart';
import 'package:flutter_application_1/layout/style/icon_broken.dart';
import 'package:flutter_application_1/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.isNotEmpty,
          builder: (context) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5,
                    margin: const EdgeInsets.all(8),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Image.asset(
                          'assets/image/logo.jpg',
                          fit: BoxFit.cover,
                          height: 220,
                          width: double.infinity,
                        ),
                        Text(
                          "communicate with friends",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    //الاثنين الي تحت عملتهم عشان انا وسط scrolView
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: SocialCubit.get(context).posts.length,
                    itemBuilder: (context, index) {
                      return buildPostIrem(context,
                          SocialCubit.get(context).posts[index], index);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      height: 10,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            );
          },
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildPostIrem(BuildContext context, PostModel model, index) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            model.name,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 16,
                          ),
                        ],
                      ),
                      Text(
                        model.dateTime,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 16,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Container(
                color: Colors.grey[300],
                height: 1,
                width: double.infinity,
              ),
            ),
            Text(
              model.text,
              style: Theme.of(context).textTheme.titleMedium,
            ),

            // Padding(
            //   padding: const EdgeInsets.only(top: 5.0, bottom: 10),
            //   child: SizedBox(
            //     width: double.infinity,
            //     child: Wrap(
            //       children: [
            //         SizedBox(
            //           height: 25,
            //           child: MaterialButton(
            //             height: 25.0,
            //             minWidth: 1,
            //             padding: EdgeInsets.zero,
            //             onPressed: () {},
            //             child: const Text(
            //               '#software',
            //               style: TextStyle(color: Colors.blue, fontSize: 12),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            if (model.postImage != "")
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        model.postImage,
                      ),
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Heart,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${SocialCubit.get(context).likeNum[index]}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              IconBroken.Chat,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Comments",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              height: 1,
              width: double.infinity,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
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
                        MaterialButton(
                          onPressed: () => navigatTo(
                            context,
                            CommentsScreen(
                              postId: SocialCubit.get(context).likePosts[index],
                            ),
                          ),
                          child: Text(
                            "write a comments",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    SocialCubit.get(context)
                        .getComments(SocialCubit.get(context).likePosts[index]);
                    SocialCubit.get(context)
                        .likePost(SocialCubit.get(context).likePosts[index]);
                  },
                  child: Row(
                    children: [
                      const Icon(
                        IconBroken.Heart,
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Likes",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
