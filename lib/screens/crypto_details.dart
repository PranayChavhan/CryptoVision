import 'dart:convert';

import 'package:cryptovision/components/myappbar.dart';
import 'package:cryptovision/components/text_medium.dart';
import 'package:flutter/material.dart';
import 'package:cryptovision/components/text_medium.dart';
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
  Map<String, dynamic>? ticker;
  List<PricePoint>? points;

  double x = 0.0;

  @override
  void initState() {
    super.initState();
    streamListener();
    points = [];
  }

  streamListener() {
    channel = IOWebSocketChannel.connect(
        'wss://stream.binance.com:9443/ws/${widget.symbol.toLowerCase()}@ticker');
    channel.stream.listen((message) {
      setState(() {
        ticker = jsonDecode(message);
        double prize = double.parse(ticker!['c']);
        double y = prize + double.parse(ticker!['p']);
        x += 0.00000001;

        print("x " + x.toString() + " y " + y.toString());

        points!.add(PricePoint(x: x, y: y));
        //print(double.parse(ticker!s!['k']['o']));
        // print(ticker!s.t    oString());
        // for (final ticker! in ticker!s) {
        //   final symbol = ticker!['s'];
        //   final price = ticker!['c'];
        //   final volume = ticker!['v'];
        //   final change = ticker!['P'];
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
      body: Container(
        color: Colors.grey.shade900,
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: (points == null || ticker == null)
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    AspectRatio(
                      aspectRatio: 3 / 2,
                      child: LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              spots: points!
                                  .map((point) => FlSpot(point.x, point.y))
                                  .toList(),
                              isCurved: false,
                              dotData: FlDotData(
                                show: false,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        " ${ticker!['s']}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextMedium(
                        text:
                            "Price Change: ${ticker!['p']}(% ${ticker!['P']})"),
                    TextMedium(text: "Average Price: ${ticker!['w']}"),
                    TextMedium(text: "Last Price: ${ticker!['c']}"),
                    TextMedium(text: "Last Quantity: ${ticker!['Q']}"),
                    TextMedium(text: "Best Bid Price: ${ticker!['b']}"),
                    TextMedium(text: "Best Bid Quantity: ${ticker!['B']}"),
                    TextMedium(text: "Best Ask Price: ${ticker!['a']}"),
                    TextMedium(text: "Best Ask Quantity: ${ticker!['A']}"),
                    TextMedium(text: "Open Price: ${ticker!['o']}"),
                    TextMedium(text: "High Price: ${ticker!['h']}"),
                    TextMedium(text: "low Price Price: ${ticker!['l']}"),
                    TextMedium(text: "Total Trades: ${ticker!['n']}"),
                    Material(
                        color: Colors.yellow.shade500,
                        borderRadius: BorderRadius.circular(15),
                        child: InkWell(
                            onTap: () {},
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 105),
                                child: Text("Add to wishist",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                        fontSize: 18,
                                        letterSpacing: 1)))))
                  ]),
      ),
    );
  }
}
