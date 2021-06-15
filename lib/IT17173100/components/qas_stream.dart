import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/components/qa_card.dart';
import 'package:notes_app/models/QA.dart';
import 'package:notes_app/screens/qa_screen.dart';

class QAsStream extends StatelessWidget {
  final Firestore _firestore;

  QAsStream({firestore}) : _firestore = firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('questionsandanswers').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator(
            backgroundColor: Colors.limeAccent,
          );
        }

        final results = snapshot.data.documents;
        List<NoteCard> qaCards = [];
        for (var result in results) {
          QA qaObject = QA(
              id: result.documentID,
              question: result.data['question'],
              answer: result.data['answer']);
          qaCards.add(QACard(
            qa: qaObject,
            onPressed: () {
              Navigator.pushNamed(context, QAScreen.routeName,
                  arguments: qaObject);
            },
          ));
        }

        return Column(
          children: qaCards,
        );
      },
    );
  }
}
