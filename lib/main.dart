// ignore_for_file: use_key_in_widget_constructors

import 'package:cryptovision/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CryptoVision",
      debugShowCheckedModeBanner: false,
      color: Colors.yellow,
      theme: ThemeData(
        primaryColor: Colors.yellow,
        textTheme: TextTheme(
          bodyLarge: TextStyle(
              color: Colors.white), // set the default text color to white
          bodyMedium: TextStyle(color: Colors.white),
          displayLarge: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.grey.shade200),

          // add more text styles as needed
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}
