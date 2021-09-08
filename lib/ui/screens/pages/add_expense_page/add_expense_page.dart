import 'package:flutter/material.dart';

class AddExpensePage extends StatelessWidget {
  static const String id = "add_expense_page";

  const AddExpensePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Text(
        'This app was build build by Rohan Das for RedCarpetUp internship task Sep. 2021 using base UI from JustSplit',
        style: Theme.of(context).textTheme.headline2!.copyWith(
              fontSize: MediaQuery.of(context).size.height * 0.027795426, // 25
              color: Colors.black,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
