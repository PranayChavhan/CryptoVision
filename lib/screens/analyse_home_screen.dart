// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:cryptovision/components/coin_card.dart';
import 'package:cryptovision/components/myappbar.dart';
import 'package:cryptovision/components/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;
// import '../components/coinCard.dart';
import '../models/coinModel.dart';

class AnalyseHomeScreen extends StatefulWidget {
  @override
  State<AnalyseHomeScreen> createState() => _AnalyseHomeScreenState();
  const AnalyseHomeScreen({Key? key}) : super(key: key);
}

class _AnalyseHomeScreenState extends State<AnalyseHomeScreen> {
  late IOWebSocketChannel channel;
  List<dynamic>? tickers;

  @override
  void initState() {
    super.initState();
    getCoinMarket();
  }

  bool isRefreshing = true;

  List? coinMarket = [];
  var coinMarketList;
  Future<List<CoinModel>?> getCoinMarket() async {
    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';

    setState(() {
      isRefreshing = true;
    });
    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    setState(() {
      isRefreshing = false;
    });
    if (response.statusCode == 200) {
      var x = response.body;
      print(x);
      coinMarketList = coinModelFromJson(x);
      setState(() {
        coinMarket = coinMarketList;
      });
    } else {
      print(coinMarket);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const MyAppBar(title: "Crypto Vision"),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            height: 80.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TopStatsCard("Market Cap", "\$24.3", "2.5%"),
                TopStatsCard("24th Volume", "\$123B", "2.5%"),
                TopStatsCard("BTC Dominance", "\$60.5", "2.5%"),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(12.0),
          //   //Search Box
          //   child: searchBox(),
          // ),
          const SizedBox(height: 10.0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: isRefreshing == true
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xffFBC700),
                      ),
                    )
                  : coinMarket == null || coinMarket!.length == 0
                      ? const Padding(
                          padding: EdgeInsets.all(10),
                          child: Center(
                            child: Text(
                              'Attention this Api is free, so you cannot send multiple requests per second, please wait and try again later.',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: coinMarket!.length,
                          itemBuilder: (context, index) {
                            return CoinCard(
                              item: coinMarket![index],
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }

  //Widgets--------------------------------------------------------------------
  Column TopStatsCard(String title, String cost, String change) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          cost.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              change.toString(),
              style: const TextStyle(
                color: Colors.green,
                fontSize: 14.0,
              ),
            ),
            const SizedBox(height: 5.0),
            const Icon(
              Icons.arrow_drop_up,
              color: Colors.green,
              size: 30.0,
            ),
          ],
        ),
      ],
    );
  }

  // Search Box ---------------------
  // Widget searchBox() {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 15),
  //     decoration: BoxDecoration(
  //       color: Colors.grey.shade800,
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     child: const TextField(
  //       style: TextStyle(color: Colors.white),
  //       // onChanged: (value) => _runFilter(value),
  //       decoration: InputDecoration(
  //         contentPadding: EdgeInsets.all(0),
  //         prefixIcon: Icon(Icons.search, color: Colors.white, size: 20),
  //         prefixIconConstraints: BoxConstraints(minHeight: 20, minWidth: 25),
  //         border: InputBorder.none,
  //         hintText: 'Search',
  //         hintStyle: TextStyle(color: Colors.white, fontSize: 15),
  //       ),
  //     ),
  //   );
  // }
}
