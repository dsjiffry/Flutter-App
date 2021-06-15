import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/components/qas_stream.dart';
import 'package:notes_app/components/qa_card.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/QA.dart';
import 'package:notes_app/screens/qa_screen.dart';

class QAsScreen extends StatefulWidget {
  static final String routeName = '/';

  @override
  _QAsScreenState createState() => _QAsScreenState();
}

class _QAsScreenState extends State<QAsScreen> {
  final Firestore _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Q & A'),
      ),
      body: ListView(
        children: <Widget>[QAsStream(firestore: _firestore)],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, QAScreen.routeName);
        },
        backgroundColor: Colors.limeAccent,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
