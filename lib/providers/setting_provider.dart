import 'package:flutter/material.dart';

class SettingProvider with ChangeNotifier{
  ThemeMode appMode=ThemeMode.dark;
  String appLanguage='en';

  void changeMode(ThemeMode selectedTheme){
    appMode=selectedTheme;
    notifyListeners();
  }

  void changeLanguage(String selectedLanguage){
    appLanguage=selectedLanguage;
    notifyListeners();
  }

}