// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings

import 'package:cryptovision/screens/analyse_details.screen.dart';
import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  var item;
  CoinCard({super.key, this.item});

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: GestureDetector(
        onTap: () {
          // Handle tap event
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (contest) => AnalyseDetailsScreen(
                        selectItem: item,
                      )));
        },
        child: Container(
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
                    child: SizedBox(
                      height: myHeight * 0.035,
                      child: Image.network(item.image),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.id,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.priceChange24H.toString().contains('-')
                        ? "-\$${item.priceChange24H.toStringAsFixed(2).toString().replaceAll('-', '')}"
                        : "\$" + item.priceChange24H.toStringAsFixed(2),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    item.marketCapChangePercentage24H.toStringAsFixed(2) + '%',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: item.marketCapChangePercentage24H >= 0
                            ? Colors.green
                            : Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
