import 'dart:convert';

import 'package:cryptovision/components/my_drawer.dart';
import 'package:cryptovision/components/myappbar.dart';
import 'package:cryptovision/screens/analyse_home_screen.dart';
import 'package:cryptovision/screens/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

import 'details_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const MyAppBar(title: "Crypto Vision"),
      drawer: MyDrawer(),
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
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    itemCount: tickers?.length ?? 0,
                    itemBuilder: (BuildContext context, int position) {
                      final ticker = tickers![position];
                      final String symbol = ticker['s'].toString();

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                        symbol: ticker['s'].toString(),
                                      )));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10.0),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          height: 80.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 40.0,
                                    width: 40.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blueGrey[800],
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.account_balance_wallet,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        symbol,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(
                                        "${ticker['c']}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ticker['p'].toString(),
                                    style: TextStyle(
                                      color: ticker['p']
                                                  .toString()
                                                  .characters
                                                  .first ==
                                              "-"
                                          ? Colors.red
                                          : Colors.green,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Icon(
                                    Icons.arrow_drop_up,
                                    color: ticker['p']
                                                .toString()
                                                .characters
                                                .first ==
                                            "-"
                                        ? Colors.red
                                        : Colors.green,
                                    size: 30.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          cost.toString(),
          style: TextStyle(
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
              style: TextStyle(
                color: Colors.green,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 5.0),
            Icon(
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
        padding: EdgeInsets.symmetric(vertical: 35, horizontal: 25),
        color: Colors.grey.shade900,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,

          children: [
            Container(
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
                leading: const Icon(Icons.query_stats, color: Colors.white),
                title: const Text(
                  'Analitics',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AnalyseHomeScreen()));
                },
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NewsScreen()));
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
      child: TextField(
        style: TextStyle(color: Colors.white),
        // onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
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
