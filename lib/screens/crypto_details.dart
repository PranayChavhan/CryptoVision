import 'dart:convert';

import 'package:cryptovision/components/myappbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:cryptovision/components/line_chart_widget.dart';
import 'package:cryptovision/data/price_point.dart';

class CryptoDetails extends StatefulWidget {
  String symbol;
  CryptoDetails({Key? key, required this.symbol}) : super(key: key);

  @override
  State<CryptoDetails> createState() => _CryptoDetailsState();
}

class _CryptoDetailsState extends State<CryptoDetails> {
  late IOWebSocketChannel channel;
  Map<String, dynamic>? tickers;

  @override
  void initState() {
    super.initState();
    streamListener();
  }

  streamListener() {
    channel = IOWebSocketChannel.connect(
        'wss://stream.binance.com:9443/ws/${widget.symbol.toLowerCase()}@kline_1s');
    channel.stream.listen((message) {
      setState(() {
        tickers = jsonDecode(message); //
        print(TextAlignVertical.center);
        // print(tickers.t    oString());
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
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        child: (tickers != null)
            ? Column(children: [
                LineChartWidget(pricePoints),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Column(children: [
                    Text(
                      tickers!['s'].toString(),
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    Text("Interval:" + tickers!['k'].toString(),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400)),
                  ]),
                )
              ])
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
