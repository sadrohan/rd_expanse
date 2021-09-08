import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rd_expanse/ui/components/balance_card.dart';
import 'package:rd_expanse/ui/components/custom_appbar.dart';
import 'package:rd_expanse/ui/components/custom_tile.dart';
import 'package:rd_expanse/ui/constants.dart';
import 'package:rd_expanse/ui/screens/pages/notes_page/notes_page.dart';

class AllExpensesPage extends StatefulWidget {
  static const String id = "all_expenses_page";

  const AllExpensesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AllExpensesPage> createState() => _AllExpensesPageState();
}

class _AllExpensesPageState extends State<AllExpensesPage> {
  @override
  void initState() {
    super.initState();
    getMessages();
  }

  Future<void> getMessages() async {
    await query.getAllSms.then((value) {
      if (value.length > 30) {
        messages = value.sublist(0, 30);
      } else {
        messages = value;
      }
      setState(() {});
    });
  }

  SMS? processSMS(String? str) {
    if (str != null) {
      str = str.toUpperCase();

      if (str.contains('DEBITED') || str.contains('CREDITED')) {
        final int accIndex = str.indexOf('XX');
        if (accIndex != -1) {
          if (RegExp(r'\d+,?\d+\.\d+').allMatches(str).length == 2) {
            return SMS(
              str.contains('DEBITED') ? 'Debited' : 'Credited',
              str.substring(accIndex, accIndex + str.substring(accIndex).indexOf(' ')).replaceAll('X', ''),
              RegExp(r'\d+,?\d+\.\d+').allMatches(str).map<String>((e) {
                return e.group(0)!;
              }).toList(),
            );
          } else {
            return null;
          }
        } else {
          return null;
        }
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      physics: const BouncingScrollPhysics(),
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        CustomAppBar(
          height: MediaQuery.of(context).size.height * 0.083099415, // 100
          expandableHeight: MediaQuery.of(context).size.height * 0.241308767, // 280
          child: BalanceCard(
            balance: messages.isEmpty
                ? 0.0
                : processSMS(messages[0].body) == null
                    ? 0.0
                    : processSMS(messages[0].body)!.bal.isEmpty
                        ? 0.0
                        : double.parse(processSMS(messages[0].body)!.bal[1].replaceAll(',', '')),
          ),
        ),
      ],
      body: messages.isNotEmpty
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03),
              child: SingleChildScrollView(
                child: Column(
                  children: messages.map(
                    (item) {
                      if (processSMS(item.body) != null) {
                        if (processSMS(item.body)!.bal.isNotEmpty) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: CustomTile(
                              name: 'A/c: XX' + processSMS(item.body)!.accNo,
                              type: processSMS(item.body)!.type,
                              balance: double.parse(processSMS(item.body)!.bal[0].replaceAll(',', '')),
                              subTitle: item.date.toString() + "\n\nClosing Bal: Rs. " + processSMS(item.body)!.bal[1],
                            ),
                          );
                        } else {
                          return SizedBox.fromSize();
                        }
                      } else {
                        return SizedBox.fromSize();
                      }
                    },
                  ).toList(),
                ),
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/illustrations/add_expense.svg',
                    width: MediaQuery.of(context).size.width * 0.80,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.040236341),
                  Text(
                    "Loading...\n",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
    );
  }
}
