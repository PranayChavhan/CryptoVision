import 'package:cryptovision/screens/analyse_home_screen.dart';
import 'package:cryptovision/screens/home_screen.dart';
import 'package:cryptovision/screens/news_screen.dart';
import 'package:cryptovision/screens/profile_screen.dart';
import 'package:cryptovision/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String _name = "Username";

  Future<void> _getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name') ?? '';
    setState(() {
      _name = name;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getName();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 35, horizontal: 25),
        color: Colors.grey.shade900,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,

          children: [
            Container(
              height: 120,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                        height: 50,
                        width: 60,
                        child: Image(
                            image: NetworkImage(
                                "https://cdn-icons-png.flaticon.com/512/4140/4140061.png"))),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        _name,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ]),
            ),
            Divider(color: Colors.grey.shade700),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                leading: const Icon(Icons.home),
                title: const Text(
                  'Home',
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen(
                                data: _name,
                              )));
                },
                selected: true,
                selectedColor: Colors.yellow,
                selectedTileColor: Colors.yellow.shade300,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                leading: const Icon(
                  Icons.query_stats,
                  color: Colors.white,
                ),
                title: const Text(
                  'Analitics',
                  style: TextStyle(),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnalyseHomeScreen()));
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                leading: const Icon(Icons.newspaper, color: Colors.white),
                title: const Text(
                  'News',
                ),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => NewsScreen()));
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                leading: const Icon(Icons.favorite_border, color: Colors.white),
                title: const Text(
                  'Wishlist',
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WishlistScreen()));
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                leading: const Icon(Icons.account_circle, color: Colors.white),
                title: const Text(
                  'Profile',
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileScreen(data: _name)));
                },
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
