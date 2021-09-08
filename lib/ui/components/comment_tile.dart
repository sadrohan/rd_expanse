import 'package:flutter/material.dart';
import 'package:rd_expanse/ui/constants.dart';

class CommentTile extends StatelessWidget {
  final String original;
  final String comment;
  final String commentId;
  final String dateTime;
  final bool isTransaction;

  const CommentTile({
    Key? key,
    required this.original,
    required this.commentId,
    required this.comment,
    required this.dateTime,
    required this.isTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: kBorderRadius,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColorDark.withOpacity(0.030),
            offset: const Offset(0.0, 5.0),
            blurRadius: 10,
            spreadRadius: 0.04,
          ),
        ],
      ),
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              original,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: MediaQuery.of(context).size.height * 0.017565438, // 14
                  ),
            ),
            const SizedBox(height: 5.0),
            Text(
              comment,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: MediaQuery.of(context).size.height * 0.017565438, // 14
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 5.0),
          ],
        ),
        subtitle: Text(
          dateTime,
          style: Theme.of(context).textTheme.headline4!.copyWith(
                fontSize: MediaQuery.of(context).size.height * 0.012235818,
                fontWeight: FontWeight.bold,
              ),
        ),
        trailing: Icon(
          isTransaction ? Icons.check : Icons.clear,
          color: Theme.of(context).primaryIconTheme.color!.withOpacity(0.50),
          size: MediaQuery.of(context).size.height * 0.0225,
        ),
      ),
    );
  }
}
