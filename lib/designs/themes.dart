import 'package:flutter/material.dart';

class ProjTheme extends ChangeNotifier {
  static ThemeData _currentTheme = ThemeData.light();

  ThemeData get darkTheme => ThemeData.dark();

  ThemeData get lightTheme => ThemeData.light();

  ThemeData get currentTheme => _currentTheme;

  void setCurrentTheme(ThemeData newTheme) {
    _currentTheme = newTheme;

    notifyListeners();
  }
}
