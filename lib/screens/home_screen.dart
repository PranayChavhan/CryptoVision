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
    channel = IOWebSocketChannel.connect('wss://stream.binance.com:9443/ws/!ticker@arr');
    channel.stream.listen((message) {
      setState(() {
        tickers = jsonDecode(message);
        print(tickers.length);
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
      backgroundColor: Colors.blueAccent,
      body: Center(
          child: ListView.builder(
              itemBuilder: (BuildContext context, int position){
                final ticker = tickers[position];

                if(ticker != null){
                  final String symbol = ticker['s'].toString() ?? "DUMMY";
                  return ListTile(
                    title: Text(symbol),
                    trailing: Text(ticker['c'].toString()),
                  );
                }else {
                  return const ListTile(
                    title: Text("NULL data"),
                  );
                }

              }
          )
      ),
    );
  }
}
