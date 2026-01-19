import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/cubits/social_state.dart';
import 'package:flutter_application_1/layout/models/social_user_model.dart';
import 'package:flutter_application_1/layout/modules/chats/chats_screen.dart';
import 'package:flutter_application_1/layout/modules/feeds/feeds_screen.dart';
import 'package:flutter_application_1/layout/modules/newpost/new_post_screen.dart';
import 'package:flutter_application_1/layout/modules/settings/settings_screen.dart';
import 'package:flutter_application_1/layout/modules/users/users_screen.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;
  void getUserData() {
    emit(SocialGetUserLodingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then(
      (value) {
        //  print(value.data());
        userModel = SocialUserModel.fromJson(value.data());
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
    const NewPostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  List<String> title = [
    ' Home',
    ' Chats',
    'Post',
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

  //دالة جلب صورة
  var picker = ImagePicker();
  File? profileImage;

  Future getProfileImage() async {
    final pickedFie = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFie != null) {
      profileImage = File(pickedFie.path);
      emit(SocialProfileImagePickertSuccessState());
    } else {
      print("Not image selected");
      emit(SocialProfileImagePickertEroorState());
    }
  }

  //دالة جلب صورة
  File? coverImage;

  Future getCoverImage() async {
    final pickedFie = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFie != null) {
      coverImage = File(pickedFie.path);
      emit(SocialCoverImagePickertEroorState());
    } else {
      print("Not image selected");
      emit(SocialCoverImagePickertEroorState());
    }
  }

//رفع صورة
/*
ref: بدخل جوا التخزين
child: بتحرك جوا كيف 
هنا عملنا انو نصل لاخر مسار عشان اجيب الصورة واخزنها
putFile: ابدأ عملية الرفع
 */
  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialGetUserLodingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then(
      (value) {
        value.ref.getDownloadURL().then(
          (value) {
          //  emit(SocialUploadProfileImagetSuccessState());
            print(value);
            updateUser(name: name, phone: phone, bio: bio, profile: value);
          },
        ).catchError((error) {
          emit(SocialUploadProfileImagetEroorState());
        });
      },
    ).catchError((error) {
      emit(SocialUploadProfileImagetEroorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialGetUserLodingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then(
      (value) {
        value.ref.getDownloadURL().then(
          (value) {
          //  emit(SocialUploadCoverImagetSuccessState());
            print(value);
            updateUser(name: name, phone: phone, bio: bio,cover: value);
          },
        ).catchError((error) {
          emit(SocialUploadCoverImagetEroorState());
        });
      },
    ).catchError((error) {
      emit(SocialUploadCoverImagetEroorState());
    });
  }

  // void updateUserImage({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUserUpdateLoadingState());
  //   if (coverImage != null) {
  //     uploadCoverImage();
  //   } else if (profileImage != null) {
  //     uploadProfileImage();
  //   } else {
  //     updateUser(name: name, phone: phone, bio: bio);
  //   }
  // }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? profile,
  }) {
    FirebaseFirestore.instance.collection('users').doc(userModel!.uId).update({
      'name': name,
      'phone': phone,
      'bio': bio,
      'cover': cover ?? userModel?.cover,
      'profile': profile ?? userModel?.image,
    }).then(
      (value) {
        getUserData();
      },
    ).catchError((error) {
      emit(SocialUserUpdateEroorState());
    });
  }
}
