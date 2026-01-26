import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade800,
    primary: Colors.grey.shade700,
    secondary: Colors.grey.shade900,
    inversePrimary: Colors.grey.shade200,
  ),

  textTheme: ThemeData.dark().textTheme.apply(
    bodyColor: Colors.grey.shade300,
    displayColor: Colors.white,
  ),
);
