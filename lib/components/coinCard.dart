// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings

import 'package:cryptovision/screens/crypto_details.dart';
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (contest) => CryptoDetails(
                        selectItem: item,
                      )));
        },
        child: Container(
          padding: EdgeInsets.only(
            left: myWidth * 0.03,
            right: myWidth * 0.06,
            top: myHeight * 0.02,
            bottom: myHeight * 0.02,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: myHeight * 0.035,
                    child: Image.network(item.image),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    item.id,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    item.priceChange24H.toString().contains('-')
                        ? "-\$${item.priceChange24H.toStringAsFixed(2).toString().replaceAll('-', '')}"
                        : "\$" + item.priceChange24H.toStringAsFixed(2),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    item.marketCapChangePercentage24H.toStringAsFixed(2) + '%',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: item.marketCapChangePercentage24H >= 0
                            ? Colors.green
                            : Colors.red),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
