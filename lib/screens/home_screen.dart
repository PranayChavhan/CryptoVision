import 'dart:convert';

import 'package:cryptovision/screens/crypto_details.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
  final String data;
  HomeScreen({Key? key, required this.data}) : super(key: key);
}

class _HomeScreenState extends State<HomeScreen> {
  late IOWebSocketChannel channel;
  List<dynamic>? tickers;

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
        body: (tickers == null) ? const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          )
        ):Center(child:
            ListView.builder(itemBuilder: (BuildContext context, int position) {
          final ticker = tickers![position];

          if (ticker != null) {
            final String symbol = ticker['s'].toString() ?? "DUMMY";
            return Container(

              decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const CryptoDetails()));
                },
                title: Text(symbol, style: TextStyle(
                    color: Colors.black,
                  fontSize: 20

                  ),
                ),
                trailing: Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Column(
                    children: [
                      Text(
                        "${ticker['c']}",
                          style: const TextStyle(
                          color: Colors.black,
                            fontSize: 20

                        ),
                      ),
                      Text(ticker['p'].toString(),
                        style: TextStyle(
                            color: ticker['p'].toString().characters.first == "-" ? Colors.red : Colors.blue
                        ),
                      )
                    ],
                  ),
                ),

              ),
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
                  widget.data,
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
