import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rd_expanse/ui/components/comment_tile.dart';
import 'package:rd_expanse/ui/components/custom_appbar.dart';
import 'package:rd_expanse/ui/constants.dart';

/// ITS PERSONAL COMMENTS PAGE. Just The sdk was made with comment as its name.
class NotesPage extends StatefulWidget {
  static const String id = "notes_page";

  const NotesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
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

  SMS? processSMS(String str) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          CustomAppBar(
            height: MediaQuery.of(context).size.height * 0.080740823,
            expandableHeight: MediaQuery.of(context).size.height * 0.125740823,
            child: Container(
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.02, horizontal: MediaQuery.of(context).size.width * 0.050611111),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "SMS Parsing Info",
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: MediaQuery.of(context).size.height * 0.033354511, // 30
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        body: messages.isNotEmpty
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03), // 20
                child: SingleChildScrollView(
                  child: Column(
                    children: messages
                        .map((item) => Padding(
                              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.005),
                              child: CommentTile(
                                commentId: item.id.toString(),
                                original: item.body ?? 'empty',
                                comment: (processSMS(item.body ?? 'empty') ?? 'Not a transaction sms').toString(),
                                dateTime: item.sender ?? 'empty',
                                isTransaction: processSMS(item.body ?? 'empty') != null,
                              ),
                            ))
                        .toList(),
                  ),
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/illustrations/add_notes.svg',
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
      ),
    );
  }
}

class SMS {
  SMS(this.type, this.accNo, this.bal);

  final String type;
  final String accNo;
  final List<String> bal;

  @override
  String toString() {
    return 'Parsed Summary:-\nA/c: XX' + accNo + '\nRs. ' + bal[0] + ' ' + type + '\nBal: Rs. ' + bal[1];
  }
}
