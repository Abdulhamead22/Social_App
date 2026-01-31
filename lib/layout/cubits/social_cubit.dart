import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/cubits/social_state.dart';
import 'package:flutter_application_1/layout/models/chat_model.dart';
import 'package:flutter_application_1/layout/models/post_model.dart';
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
  PostModel? postModel;

  //دالة جلب بيانات المستخدم
  void getUserData() {
    emit(SocialGetUserLodingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then(
      (value) {
        //  print(value.data());
        userModel = SocialUserModel.fromJson(value.data());
        emit(SocialGetUserSuccessState());
      },
    ).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
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
    if (index == 1) {
      getAllUser();
    }
    if (index == 2) {
      emit(SocialNeewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeNagBarState());
    }
  }

  //دالة جلب صورة بروفايل
  var picker = ImagePicker();
  File? profileImage;

  Future getProfileImage() async {
    final pickedFie = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFie != null) {
      profileImage = File(pickedFie.path);
      emit(SocialProfileImagePickertSuccessState());
    } else {
      print("Not image selected");
      emit(SocialProfileImagePickertErrorState());
    }
  }

  //دالة جلب صورة غلاف
  File? coverImage;

  Future getCoverImage() async {
    final pickedFie = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFie != null) {
      coverImage = File(pickedFie.path);
      emit(SocialCoverImagePickertSuccessState());
    } else {
      print("Not image selected");
      emit(SocialCoverImagePickertErrorState());
    }
  }

//رفع صورة
/*
ref: بدخل جوا التخزين
child: بتحرك جوا كيف 
هنا عملنا انو نصل لاخر مسار عشان اجيب الصورة واخزنها
putFile: ابدأ عملية الرفع
 */
//رفع صورة للبروفايل

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
            print(value);
            updateUser(name: name, phone: phone, bio: bio, profile: value);
          },
        ).catchError((error) {
          emit(SocialUploadProfileImagetErrorState());
        });
      },
    ).catchError((error) {
      emit(SocialUploadProfileImagetErrorState());
    });
  }

//رفع صورة للغلاف

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
            print(value);
            updateUser(name: name, phone: phone, bio: bio, cover: value);
          },
        ).catchError((error) {
          emit(SocialUploadCoverImagetErrorState());
        });
      },
    ).catchError((error) {
      emit(SocialUploadCoverImagetErrorState());
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

//تحديث البيانات
  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? profile,
  }) {
          emit(SocialUserUpdateLoadingState());

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
      emit(SocialUserUpdateErrorState());
    });
  }

//جلب صورة للبوست
  File? postImage;

  Future getpostImage() async {
    final pickedFie = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFie != null) {
      postImage = File(pickedFie.path);
      emit(SocialPostImagePickertSuccessState());
    } else {
      print("Not image selected");
      emit(SocialPostImagePickertErrorState());
    }
  }

//حلب بيانات البوست

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    emit(SocialCreatePostLodingState());
    //طريفة عن طريق استخدام كلاس postModel
    postModel = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? "",
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(
          postModel!.toMap(),
        )
        .then(
      (value) {
        emit(SocialCreatePostSuccessState());
      },
    ).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

//رفع صورة للبوست
  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLodingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then(
      (value) {
        value.ref.getDownloadURL().then(
          (value) {
            print(value);
            createPost(
              dateTime: dateTime,
              text: text,
              postImage: value,
            );
          },
        ).catchError((error) {
          emit(SocialCreatePostErrorState());
        });
      },
    ).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  //جلب بيانات البوست
  List<PostModel> posts = [];
  List<String> likePosts = [];
  List<int> likeNum = [];

  void getPostsData() {
    emit(SocialGetPostLodingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .snapshots()
        .listen(
      (event) async {
        posts = [];
        likePosts = [];
// اعملت هادا عشان كل بوست ينتظر اللايكات تبعه قبل الإضافة.
        event.docs.forEach(
          (element) {
            element.reference.collection('likes').get().then(
              (value) {
                likeNum.add(value.docs.length);
                likePosts.add(element.id);
                posts.add(PostModel.fromJson(element.data()));
              },
            ).catchError((error) {
              emit(SocialGetPostErrorState(error.toString()));
            });
          },
        );
        emit(SocialGetPostSuccessState());
      },
    );
    //طريقة ثانية
    // FirebaseFirestore.instance.collection('posts').get().then(
    //   (value) {
    //     value.docs.forEach(
    //       (element) {
    //         element.reference.collection('likes').get().then(
    //           (value) {
    //             likeNum.add(value.docs.length);
    //             likePosts.add(element.id);
    //             posts.add(PostModel.fromJson(element.data()));
    //           },
    //         ).catchError((error) {});
    //       },
    //     );
    //     emit(SocialGetPostSuccessState());
    //   },
    // ).catchError((error) {
    //   emit(SocialGetPostErrorState(error.toString()));
    // });
  }

  //زر اللايك

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then(
      (value) {
        emit(SocialLikePostSuccessState());
      },
    ).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  //زر التعليق
  /* هدول بعملوا: .orderBy('dateTime')
      .snapshots()
      .listen : 
  رتبهم حسب الوقت،
وخليني أسمع لأي تغيير يصير عليهم،
وكل مرة يصير تغيير حدّث الليست
   */
  List<Map<String, dynamic>> commentNum = [];
  void getComments(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('dateTime')
        .snapshots()
        .listen((value) {
      commentNum = value.docs.map((e) => e.data()).toList();
      emit(SocialGetCommentsSuccessState());
    });
  }

  void commentPost(String postId, String comments) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add({
      'uId': userModel!.uId,
      'name': userModel!.name,
      'image': userModel!.image,
      'comments': comments,
      'dateTime': Timestamp.now().toString(),
    }).then(
      (value) {
        emit(SocialCommentsPostSuccessState());
      },
    ).catchError((error) {
      emit(SocialCommentsPostErrorState(error.toString()));
    });
  }

//جلب user
  List<SocialUserModel> user = [];

  void getAllUser() {
    if (user.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then(
        (value) {
          value.docs.forEach(
            (element) {
              if (element.data()['uId'] != userModel!.uId) {
                user.add(SocialUserModel.fromJson(element.data()));
              }
            },
          );
          emit(SocialGetAllUserSuccessState());
        },
      ).catchError((error) {
        emit(SocialGetAllUserErrorState(error.toString()));
      });
    }
  }

//send and recive message

  void sendmessage({
    required String text,
    required String receiverId,
    required String dateTime,
  }) {
    ChatModel model = ChatModel(
        dateTime: dateTime,
        senderId: userModel!.uId,
        receiverId: receiverId,
        text: text);

//my chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(model.toMap())
        .then(
      (value) {
        emit(SocialSendMessageSuccessState());
      },
    ).catchError((error) {
      emit(SocialSendMessageErrorState());
    });

//receiver chat
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('message')
        .add(model.toMap())
        .then(
      (value) {
        emit(SocialSendMessageSuccessState());
      },
    ).catchError((error) {
      emit(SocialSendMessageErrorState());
    });
  }

  List<ChatModel> message = [];
  void getmessage(String receiverId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((value) {
      message = [];

      value.docs.forEach(
        (element) {
          message.add(ChatModel.fromJson(element.data()));
        },
      );
      emit(SocialGetMessageSuccessState());
    });
  }
}
