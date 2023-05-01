import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late IOWebSocketChannel channel;
  late List<dynamic> tickers;

  @override
  void initState() {
    super.initState();
    streamListener();
  }

  streamListener() {
    channel = IOWebSocketChannel.connect(
        'wss://stream.binance.com:9443/ws/!ticker@arr');
    channel.stream.listen((message) {
      setState(() {
        tickers = jsonDecode(message);
        print(tickers.toString());
        // for (final ticker in tickers) {
        //   final symbol = ticker['s'];
        //   final price = ticker['c'];
        //   final volume = ticker['v'];
        //   final change = ticker['P'];
        //   print('$symbol: $price ($change%)');
        // }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        drawer: _buildDrawer(context),
        body: Center(child:
            ListView.builder(itemBuilder: (BuildContext context, int position) {
          final ticker = tickers[position];

          print(ticker);
          if (ticker != null) {
            final String symbol = ticker['s'].toString() ?? "DUMMY";
            return ListTile(
              title: Text(symbol),
              trailing: Text(ticker['c'].toString()),
            );
          } else {
            return const ListTile(
              title: Text("NULL data"),
            );
          }
        })));
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  height: 60,
                  width: 60,
                  child: Image(
                      image: NetworkImage(
                          "https://cdn-icons-png.flaticon.com/512/4140/4140061.png"))),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  "Ayush Bulbule",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              )
            ]),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
              selected: true,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              leading: Icon(
                Icons.newspaper,
              ),
              title: const Text('News'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              leading: Icon(
                Icons.account_circle,
              ),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "CryptoVision",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_outline,
                color: Colors.white,
                size: 22,
              )),
        ]);
  }
}
