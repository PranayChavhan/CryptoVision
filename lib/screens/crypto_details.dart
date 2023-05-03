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
  List<PricePoint>? points;

  @override
  void initState() {
    super.initState();
    streamListener();
    points = [];
  }

  streamListener() {
    channel = IOWebSocketChannel.connect(
        'wss://stream.binance.com:9443/ws/${widget.symbol.toLowerCase()}@kline_1s');
    channel.stream.listen((message) {

      setState(() {
        tickers = jsonDecode(message); //
        points!.add(PricePoint(x: double.parse(tickers!['k']['o']*10), y: double.parse(tickers!['k']['c']*10)));
        print(double.parse(tickers!['k']['o']));
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
        title: const Text(
          "CryptoVision",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
      body: (points == null) ? 
      CircularProgressIndicator() :  
      Column(children: [
        AspectRatio(
          aspectRatio: 2,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: points!.map((point) => FlSpot(point.x, point.y)).toList(),
                  isCurved: false,
                  // dotData: FlDotData(
                  //   show: false,
                  // ),
                ),
              ],
            ),
          ),
        ),
        Text(
          tickers!['k']['s'],
        ), Text(
          "Open Prize " + tickers!['k']['o'],
        ),

      ]),
    );
  }
}
