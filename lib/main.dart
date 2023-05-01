// ignore_for_file: use_key_in_widget_constructors

import 'package:cryptovision/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "CryptoVision",
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
