import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({Key? key, required this.balance}) : super(key: key);

  final double balance;

  @override
  Widget build(BuildContext context) {
    final _greenGradient = LinearGradient(
      colors: [
        Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.primaryVariant,
      ],
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
    );

    Text _displayBalance() {
      String _text = "₹ ${balance.abs().toStringAsFixed(2)}";

      return Text(
        "Current Balance\n" + _text,
        style: Theme.of(context).textTheme.headline2!.copyWith(
              fontSize: MediaQuery.of(context).size.height * 0.027795426, // 25
            ),
      );
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.210133418, // 189
      // margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.036458333), // 15
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.030458333 * 2),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(20),
        gradient: _greenGradient,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primaryVariant.withOpacity(0.25),
            blurRadius: 15.0,
            offset: const Offset(3.0, 5.0),
            spreadRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi there!",
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  fontSize: MediaQuery.of(context).size.height * 0.027795426, // 25
                ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.031013596), // 35
          _displayBalance(),
        ],
      ),
    );
  }
}
