import 'package:cryptovision/components/my_drawer.dart';
import 'package:cryptovision/components/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "WishList"),
      drawer: MyDrawer(),
      body: Container(
        color: Colors.grey.shade900,
        child: Center(child: Text("Wishlist")),
      ),
    );
  }
}
