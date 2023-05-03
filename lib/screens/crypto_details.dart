import 'package:cryptovision/components/myappbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CryptoDetails extends StatefulWidget {
  const CryptoDetails({Key? key}) : super(key: key);

  @override
  State<CryptoDetails> createState() => _CryptoDetailsState();
}

class _CryptoDetailsState extends State<CryptoDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "CryptoVision",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(child: Text("Hello Js")),
    );
  }
}
