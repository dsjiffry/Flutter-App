import 'package:flutter/material.dart';
import 'package:assignment_2021_jun_we_12/IT17173100/constants.dart';
import 'package:assignment_2021_jun_we_12/IT17173100/models/QA.dart';

class QACard extends StatelessWidget {
  final QA qa;
  final Function onPressed;

  QACard({this.qa, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        margin: EdgeInsets.symmetric(
            horizontal: kLargeMargin, vertical: kSmallMargin),
        child: ListTile(
          title: Text(qa.question),
          subtitle: Text(qa.answer),
        ),
      ),
    );
  }
}
