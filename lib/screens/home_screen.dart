import 'dart:convert';

import 'package:cryptovision/components/myappbar.dart';
import 'package:cryptovision/screens/crypto_details.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

import 'news_screen.dart';

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
        // print(tickers.toString());
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
        appBar: const MyAppBar(title: "CryptoVision"),
        drawer: _buildDrawer(context),
        body: (tickers == null)
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.black,
              ))
            : Center(
                child: ListView.builder(
                    itemCount: tickers?.length ?? 0,
                    itemBuilder: (BuildContext context, int position) {
                      final ticker = tickers![position];

                      if (ticker != null) {
                        final String symbol = ticker['s'].toString() ?? "DUMMY";
                        return ListTile(
                          shape: BeveledRectangleBorder(
                              side: BorderSide(
                                  color: Colors.grey.shade500, width: .5)),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CryptoDetails(
                                          symbol: ticker['s'].toString(),
                                        )));
                          },
                          title: Text(
                            symbol,
                            style: const TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${ticker['c']}",
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                                Text(
                                  ticker['p'].toString(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: ticker['p']
                                                  .toString()
                                                  .characters
                                                  .first ==
                                              "-"
                                          ? Colors.red
                                          : Colors.green
                                  ),
                                )
                              ],
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      height: 50,
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
              leading: const Icon(
                Icons.newspaper,
              ),
              title: const Text('News'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) =>
                const NewsScreen()
                )
                );

              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              leading: const Icon(
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
}
