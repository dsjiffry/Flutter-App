import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:assignment_2021_jun_we_12/IT17173100/components/qas_stream.dart';
import 'package:assignment_2021_jun_we_12/IT17173100/screens/qa_screen.dart';

class QAsScreen extends StatefulWidget {
  static final String routeName = '/';

  @override
  _QAsScreenState createState() => _QAsScreenState();
}

class _QAsScreenState extends State<QAsScreen> {
  FirebaseFirestore _firestore;
  Future<void> init() async {
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
  }

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
