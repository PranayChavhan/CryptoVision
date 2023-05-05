import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:cryptovision/data/price_point.dart';
import 'package:web_socket_channel/io.dart';

class LineChartWidget extends StatefulWidget {
  String symbol;
  final List<PricePoint> points;

  LineChartWidget(this.points, {Key? key, required this.symbol})
      : super(key: key);

  @override
  State<LineChartWidget> createState() => _LineChartWidgetState();
}

class _LineChartWidgetState extends State<LineChartWidget> {
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
      });
    });
  }

  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: widget.points
                  .map((point) => FlSpot(point.x, point.y))
                  .toList(),
              isCurved: false,
              // dotData: FlDotData(
              //   show: false,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
