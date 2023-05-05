// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:convert';

import 'package:cryptovision/components/myappbar.dart';
import 'package:cryptovision/screens/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;
import '../components/coinCard.dart';
import '../models/coinModel.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
  final String data;
  const HomeScreen({Key? key, required this.data}) : super(key: key);
}

class _HomeScreenState extends State<HomeScreen> {
  late IOWebSocketChannel channel;
  List<dynamic>? tickers;

  @override
  void initState() {
    super.initState();
    getCoinMarket();
    streamListener();
  }

  bool isRefreshing = true;
  streamListener() {
    channel = IOWebSocketChannel.connect(
        'wss://stream.binance.com:9443/ws/!ticker@arr');
    channel.stream.listen((message) {
      setState(() {
        tickers = jsonDecode(message);
      });
    });
  }

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
      coinMarketList = coinModelFromJson(x);
      setState(() {
        coinMarket = coinMarketList;
      });
    } else {
      print(coinMarket);
    }
  }

  // Future<List<CoinModel>?> getCoinMarket() async {
  //   channel = IOWebSocketChannel.connect(
  //       'wss://stream.binance.com:9443/ws/!ticker@arr');
  //   var coinMarketList = <CoinModel>[];

  //   channel.stream.listen((message) {
  //     setState(() {
  //       coinMarket = jsonDecode(message);
  //       // print(coinMarket);
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const MyAppBar(title: "Crypto Vision"),
      drawer: _buildDrawer(context),
      body: (tickers == null)
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.white,
            ))
          : Column(
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
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  //Search Box
                  child: searchBox(),
                ),
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

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 25),
        color: Colors.grey.shade900,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,

          children: [
            SizedBox(
              height: 120,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                        height: 50,
                        width: 60,
                        child: Image(
                            image: NetworkImage(
                                "https://cdn-icons-png.flaticon.com/512/4140/4140061.png"))),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        widget.data,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ]),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                leading: const Icon(Icons.home, color: Colors.white),
                title: const Text(
                  'Home',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
                selected: true,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                leading: const Icon(Icons.newspaper, color: Colors.white),
                title: const Text(
                  'News',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewsScreen()));
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                leading: const Icon(Icons.account_circle, color: Colors.white),
                title: const Text(
                  'Profile',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Search Box ---------------------
  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const TextField(
        style: TextStyle(color: Colors.white),
        // onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, color: Colors.white, size: 20),
          prefixIconConstraints: BoxConstraints(minHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
