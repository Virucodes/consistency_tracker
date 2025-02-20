import 'package:flutter/material.dart';
import 'dark_mode.dart';
import 'light_mode.dart';


class ThemeProvider extends ChangeNotifier {
  //initially, light mode

  ThemeData _themeData = lightMode;

  // get current theme
  ThemeData get themeData => _themeData;

  //is current theme dart mode

  bool get isDarkMode => _themeData == darkMode;

  //set theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  //toggle theme

  void toggletheme() {
    if (_themeData == lightMode)
    {
       themeData = darkMode;
    }else
    {
       themeData = lightMode;
    }
      
  }
}
