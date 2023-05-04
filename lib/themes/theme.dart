import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
  // Define the default brightness and colors.
  brightness: Brightness.dark,
  primaryColor: Colors.yellow[400],

  // Define the default font family.

  // Define the default `TextTheme`. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
  ),
);
