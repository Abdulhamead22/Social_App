import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/cubits/social_state.dart';
import 'package:flutter_application_1/layout/models/social_user_model.dart';
import 'package:flutter_application_1/layout/modules/chats/chats_screen.dart';
import 'package:flutter_application_1/layout/modules/feeds/feeds_screen.dart';
import 'package:flutter_application_1/layout/modules/settings/settings_screen.dart';
import 'package:flutter_application_1/layout/modules/users/users_screen.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model;
  void getUserData() {
    emit(SocialGetUserLodingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then(
      (value) {
        //  print(value.data());
        model = SocialUserModel.fromJson(value.data());
        emit(SocialGetUserSuccessState());
      },
    ).catchError((error) {
      emit(SocialGetUserEroorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> page = [
    const FeedsScreen(),
    const ChatsScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  List<String> title = [
    ' Home',
    ' Chats',
    ' Users',
    'Settings',
  ];
  void changeIndex(int index) {
    if (index == 2) {
      emit(SocialNeewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeNagBarState());
    }
  }
}
