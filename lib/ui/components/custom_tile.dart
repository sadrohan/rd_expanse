import 'package:flutter/material.dart';
import 'package:rd_expanse/ui/constants.dart';

class CustomTile extends StatelessWidget {
  final double balance;
  final String name;
  final String type;
  final String? subTitle;
  final bool? isThreeLine;

  const CustomTile({
    Key? key,
    required this.name,
    this.subTitle,
    this.isThreeLine,
    required this.balance,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Text _oweOrOwedText(String type) {
      if (type == 'Debited') {
        return Text(
          "Debited",
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontSize: MediaQuery.of(context).size.height * 0.015565438,
              ),
        );
      } else if (type == 'Credited') {
        return Text(
          "Credited",
          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                fontSize: MediaQuery.of(context).size.height * 0.015565438,
              ),
        );
      } else {
        return Text(
          "Settled Up",
          style: Theme.of(context).textTheme.headline4!.copyWith(
                fontSize: MediaQuery.of(context).size.height * 0.015565438,
              ),
        );
      }
    }

    Widget _showBalanceOrNot(double netBalance, String type) {
      if (netBalance == 0.0) {
        return const SizedBox.shrink();
      } else {
        return Text(
          "₹ ${netBalance.abs().toStringAsFixed(2)}",
          style: type == 'Debited'
              ? Theme.of(context).textTheme.subtitle1!.copyWith(
                    fontSize: MediaQuery.of(context).size.height * 0.015565438,
                  )
              : Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontSize: MediaQuery.of(context).size.height * 0.015565438,
                  ),
        );
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: kBorderRadius,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColorDark.withOpacity(0.04),
            offset: const Offset(0.0, 5.0),
            blurRadius: 10,
            spreadRadius: 0.1,
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.02, vertical: MediaQuery.of(context).size.height * 0.010),
        title: Text(
          name,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                fontSize: MediaQuery.of(context).size.height * 0.016565438, // 14
              ),
        ),
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 0.5,
              color: Theme.of(context).primaryColorDark.withOpacity(0.70),
            ),
          ),
          child: CircleAvatar(
            backgroundColor: Colors.tealAccent,
            radius: MediaQuery.of(context).size.height * 0.027239517, // 24.5
            child: const FadeInImage(
              placeholder: AssetImage('assets/icons/misc/loader.png'),
              image: AssetImage('assets/avatars/bank.png'),
            ),
          ),
        ),
        subtitle: subTitle != null
            ? Text(
                subTitle!,
                style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: MediaQuery.of(context).size.height * 0.012229987,
                      fontWeight: FontWeight.w400,
                    ),
              )
            : null,
        isThreeLine: isThreeLine ?? false,
        dense: false,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _oweOrOwedText(type),
            _showBalanceOrNot(balance, type),
          ],
        ),
      ),
    );
  }
}
