import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class CryptoDetails extends StatefulWidget {
  String crypto_name;
  CryptoDetails(this.crypto_name, {Key? key}) : super(key: key);

  @override
  State<CryptoDetails> createState() => _CryptoDetailsState();
}

class _CryptoDetailsState extends State<CryptoDetails> {
  late IOWebSocketChannel channel;
  late List<dynamic> tickers;

  @override
  void initState() {
    super.initState();
    streamListener();
  }

  streamListener() {
    channel = IOWebSocketChannel.connect(
        'wss://stream.binance.com:9443/ws/' + widget.crypto_name.toLowerCase()+ "@kline_1m");
    channel.stream.listen((message) {
      setState(() {
        //tickers = jsonDecode(message);
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
    return const Scaffold(
        body: Center(
          child: Text("Details Screen"),
        ));
  }


}
