import 'package:flutter/material.dart';

class Themes {
  static final lightTheme = ThemeData(
    // colorScheme: const ColorScheme.light(),
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: const Color.fromARGB(255, 121, 166, 200),
    hintColor: Colors.orange,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.grey, fontSize: 14),
    ),

    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: Colors.blue,
      onPrimary: Colors.white,
      secondary: Colors.orange,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
  );

  static final darkTheme = ThemeData(
    // colorScheme: const ColorScheme.dark(),
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey[900],
    hintColor: Colors.orangeAccent,
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.grey, fontSize: 14),
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.blueGrey,
      onPrimary: Colors.white,
      secondary: Colors.orangeAccent,
      onSecondary: Colors.white,
      error: Colors.redAccent,
      onError: Colors.white,
      surface: Colors.black87,
      onSurface: Colors.white,
    ),
    useMaterial3: true,
  );
}
