import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Colors.blueGrey,   // = button
    secondary: Colors.orange[300]!, // operators
    tertiary: Colors.grey[700]!,        // functions
    surface: Colors.grey[850]!,         // numbers
    error: Colors.red[300]!,            // clear
    background: Colors.grey[900]!,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    onTertiary: Colors.white,
    onBackground: Colors.white70,
  ),
  scaffoldBackgroundColor: Colors.grey[900],
);
