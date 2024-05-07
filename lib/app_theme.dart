import 'package:flutter/material.dart';

class AppTheme{
  static Color mintGreen=const Color(0xFFDFECDB);
  static Color white=Colors.white;
  static Color lightBlue =const Color(0xFF5D9CEC);
  static Color green =const Color(0xFF61E757);
  static Color grey =const Color(0xFF363636);
  static Color darkPrimaryColor =const Color(0xFF141922);
  static Color darkBlue =const Color(0xFF060E1E);


  static ThemeData appLightTheme=ThemeData(
    scaffoldBackgroundColor: mintGreen,
    primaryColor: white,
    appBarTheme: AppBarTheme(
      backgroundColor: lightBlue,
      foregroundColor: white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 22,
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: const TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w700
      ),
      bodySmall: TextStyle(
          fontSize: 12,
          color: grey,
          fontWeight: FontWeight.w400
      ),
      bodyMedium: const TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.w400
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: white,
      showDragHandle: true,
      dragHandleColor: lightBlue
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightBlue,
      foregroundColor: white
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: lightBlue
    ),
  );
  static ThemeData appDarkTheme=ThemeData(
    scaffoldBackgroundColor: darkBlue,
    primaryColor: darkPrimaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: lightBlue,
      foregroundColor: white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 22,
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: const TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w700
      ),
      bodySmall: TextStyle(
          fontSize: 12,
          color: white,
          fontWeight: FontWeight.w400
      ),
      bodyMedium: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w400
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: darkPrimaryColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightBlue,
      foregroundColor: white
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: lightBlue,
      backgroundColor: darkPrimaryColor,
      unselectedItemColor: white,
    ),
  );
}