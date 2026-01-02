import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData ligthTheam = ThemeData(
  useMaterial3: false,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 28,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    actionsIconTheme: IconThemeData(
      color: Colors.black,
      size: 32,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
      size: 28,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: Colors.black,
      height: 1.3,
    ),
  ),
);

ThemeData darkTheam = ThemeData(
  scaffoldBackgroundColor: Colors.blueGrey,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 28,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.blueGrey,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Colors.blueGrey,
    elevation: 0,
    actionsIconTheme: IconThemeData(
      color: Colors.white,
      size: 32,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 28,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.blueGrey,
    selectedItemColor: Colors.amberAccent,
    unselectedItemColor: Colors.black45,
  ),
  textTheme: const TextTheme(
    titleMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      color: Colors.white,
      height: 1.3,
    ),
  ),
);
