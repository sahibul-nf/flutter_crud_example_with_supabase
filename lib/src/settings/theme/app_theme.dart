import 'package:flutter/material.dart';

class AppTheme {
  static final light = ThemeData.light().copyWith(
    backgroundColor: const Color(0xfff4f6f8),
  );

  static final dark = ThemeData.dark().copyWith(
    backgroundColor: const Color(0x00f4f6f8),
    buttonTheme: const ButtonThemeData(buttonColor: Colors.lightBlue),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.lightBlue,
      foregroundColor: Colors.white,
    ),
  );
}
