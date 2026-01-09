import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Colors.grey[400]!,   // functions: sin, cos, tan, log, sqrt, square, cube, brackets
    secondary: Colors.indigo[200]!, // operators
    tertiary: Colors.grey[300]!,    
    surface: Colors.white,          // numbers
    error: Colors.red[300]!,        // clear
    background: Colors.grey[200]!,
    onPrimary: Colors.white,        // text on operators
    onSecondary: Colors.white,
    onSurface: Colors.blueGrey[700]!, 
    onTertiary: Colors.black87,     // text on functions
    onBackground: Colors.blueGrey[700],
  ),
  scaffoldBackgroundColor: Colors.grey[200],
);
