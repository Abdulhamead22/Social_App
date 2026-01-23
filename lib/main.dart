import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/cache_helper.dart';
import 'package:flutter_application_1/layout/cubits/social_cubit.dart';
import 'package:flutter_application_1/layout/modules/login/login_screen.dart';
import 'package:flutter_application_1/layout/social_layout.dart';
import 'package:flutter_application_1/style/theam.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String? uId;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await Firebase.initializeApp();
//await FirebaseAuth.instance.signOut();
//await CacheHelper.clearData(key: 'uId');

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
      create: (context) => SocialCubit()..getUserData()..getPostsData(),
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
