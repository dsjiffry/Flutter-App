import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/QA.dart';

class NoteScreen extends StatefulWidget {
  static final String routeName = '/qa';
  Note note;

  NoteScreen(this.note);

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  QA qa;
  String questionString = '';
  String answerString = '';

  Firestore _firestore = Firestore.instance;

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
              _firestore.collection('notes').document(qa.id).delete();
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
          .document(qa.id)
          .updateData({'question': questionString, 'answer': answerString});
    }
  }
}
