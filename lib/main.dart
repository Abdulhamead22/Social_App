import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/modules/login/login_screen.dart';
import 'package:flutter_application_1/style/theam.dart';

String? isToken;
String? uId;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ligthTheam,
      darkTheme: darkTheam,
home: const LoginScreen(),    );
  }
}

