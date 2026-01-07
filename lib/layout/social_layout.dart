import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/cubits/social_cubit.dart';
import 'package:flutter_application_1/layout/cubits/social_state.dart';
import 'package:flutter_application_1/layout/modules/newpost/new_post_screen.dart';
import 'package:flutter_application_1/style/icon_broken.dart';
import 'package:flutter_application_1/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        if (state is SocialNeewPostState) {
          navigatTo(context, const NewPostScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.title[cubit.currentIndex]),
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(IconBroken.Notification)),
              IconButton(onPressed: () {}, icon: const Icon(IconBroken.Search)),
            ],
          ),
          body: cubit.page[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (value) {
              cubit.changeIndex(value);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: 'Chat'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload), label: 'Post'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Location), label: 'Users'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: 'Setting'),
            ],
          ),
        );
      },
    );
  }

  Widget emailVerified() {
    return Container(
      color: Colors.amber.withOpacity(0.6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            const Icon(Icons.info_outline),
            const SizedBox(
              width: 10,
            ),
            const Expanded(child: Text('Please verify your email')),
            const SizedBox(
              width: 15,
            ),
            defaultTextButton(
              text: 'Send',
              function: () async {
                await FirebaseAuth.instance.currentUser!.reload();

                //ما عملتها قي cubit لانو بستخدمها مرة واحدة بس
                FirebaseAuth.instance.currentUser!.sendEmailVerification().then(
                  (value) {
                    toast('Check your mail', Colors.green);
                  },
                ).catchError((error) {
                  print(error.toString());
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
