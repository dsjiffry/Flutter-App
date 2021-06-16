import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:assignment_2021_jun_we_12/IT17173100/constants.dart';
import 'package:assignment_2021_jun_we_12/IT17173100/models/QA.dart';

class QAScreen extends StatefulWidget {
  static final String routeName = '/qa';
  QA note;

  QAScreen(this.note);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<QAScreen> {
  QA qa;
  String questionString = '';
  String answerString = '';

  FirebaseFirestore _firestore;
  Future<void> init() async {
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
  }

  TextEditingController controllerTitle;
  TextEditingController controllerNote;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    qa = widget.note;
    if (qa != null) {
      questionString = qa.question;
      answerString = qa.answer;
    }

    controllerTitle =
        TextEditingController(text: qa != null ? qa.question : '');
    controllerNote = TextEditingController(text: qa != null ? qa.answer : '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(
          qa != null ? 'Edit Q & A' : 'Add Q & A',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {
              saveClicked();
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              _firestore.collection('notes').doc(qa.id).delete();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: kSmallMargin),
            child: TextField(
              controller: controllerTitle,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Question',
              ),
              onChanged: (value) {
                questionString = value;
              },
            ),
          ),
          SizedBox(
            height: kSmallMargin,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(kLargeMargin),
              child: TextField(
                controller: controllerNote,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(hintText: 'Answer'),
                onChanged: (value) {
                  answerString = value;
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void saveClicked() {
    if (qa == null) {
      _firestore
          .collection('questionsandanswers')
          .add({'question': questionString, 'question': answerString});
    } else {
      _firestore
          .collection('questionsandanswers')
          .doc(qa.id)
          .update({'question': questionString, 'answer': answerString});
    }
  }
}
