import 'package:cryptovision/components/my_drawer.dart';
import 'package:cryptovision/components/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProfileScreen extends StatelessWidget {
  final String? data;
  const ProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(title: "Profile"),
        drawer: MyDrawer(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade900,
          child: Column(children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SizedBox(
                width: 100,
                child: Image(
                    image: NetworkImage(
                        "https://cdn-icons-png.flaticon.com/512/4140/4140061.png")),
              ),
            ),
            Text("Name: ${data}",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
          ]),
        ));
  }
}
