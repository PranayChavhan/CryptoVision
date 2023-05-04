// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:cryptovision/components/myappbar.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart' as http;
import '../components/coinCard.dart';
import '../models/coinModel.dart';
import 'crypto_details.dart';
import 'news_screen.dart';

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
    streamListener();
    getCoinMarket();
  }

  streamListener() {
    channel = IOWebSocketChannel.connect(
        'wss://stream.binance.com:9443/ws/!ticker@arr');
    channel.stream.listen((message) {
      setState(() {
        tickers = jsonDecode(message);
      });
    });
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
      coinMarketList = coinModelFromJson(x);
      setState(() {
        coinMarket = coinMarketList;
      });
    } else {
      // print(response.statusCode);
    }
  }

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
                const SizedBox(height: 10.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  height: 50.0,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for cryptocurrencies',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey[400],
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[900],
                    ),
                  ),
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
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                      height: 50,
                      width: 60,
                      child: Image(
                          image: NetworkImage(
                              "https://cdn-icons-png.flaticon.com/512/4140/4140061.png"))),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      widget.data,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ]),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              leading: const Icon(
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
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              leading: const Icon(
                Icons.newspaper,
              ),
              title: const Text('News'),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const NewsScreen()),
                    (route) => false);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
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
