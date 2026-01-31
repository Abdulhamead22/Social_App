import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cache_helper.dart';
import 'package:flutter_application_1/layout/cubits/social_cubit.dart';
import 'package:flutter_application_1/layout/modules/login/login_screen.dart';
import 'package:flutter_application_1/layout/social_layout.dart';
import 'package:flutter_application_1/layout/style/theam.dart';
import 'package:flutter_application_1/widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Success');
}

String? uId;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
  //انا جوا التطبيق شو بعطيني
  FirebaseMessaging.onMessage.listen(
    (event) {
      print('Success');
    },
  ).onError((error) {
    print('Error');
  });
//هادا في حال كان التطبيق في الخلفية يعني مش مغلق كامل (محطوط بالنص ) لما اضغط عالاشعار يجبلي الي طالبوا
  FirebaseMessaging.onMessageOpenedApp.listen(
    (event) {
      print('Success');
      toast("", Colors.green);
    },
  ).onError((error) {
    print('Error');
  });
//والتطبيق مسكر شو بعطيني
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Widget? widget;
  //عشان احفظ الوصول او يعني عشان ما اضل يعيد الدخول لصفحة التسجيل كل ما اعيد البرنامج
  uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = const SocialLayout();
  } else {
    widget = const LoginScreen();
  }

  runApp(MyApp(
    startpage: widget,
  ));
  print('UID: $uId');
}

class MyApp extends StatelessWidget {
  final Widget? startpage;
  const MyApp({super.key, this.startpage});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()
        ..getUserData()
        ..getPostsData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ligthTheam,
        darkTheme: darkTheam,
        themeMode: ThemeMode.light,
        home: startpage,
      ),
    );
  }
}
