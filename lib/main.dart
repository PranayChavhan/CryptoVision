// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import './screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CryptoVision",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
