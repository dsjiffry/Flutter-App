import 'package:assignment_2021_jun_we_12/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:assignment_2021_jun_we_12/IT17029896/CustomWidgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(JobListings());
}

class JobListings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]); //Make app fullscreen
    return MaterialApp(
      title: 'Job Listings',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JobListingHomePage(
        title: 'Job Listings',
      ),
    );
  }
}

class JobListingHomePage extends StatefulWidget {
  JobListingHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  JobListingHomePageState createState() => JobListingHomePageState();
}

class JobListingHomePageState extends State<JobListingHomePage>
    with CustomWidgets {
  List<Widget> listingCards;

  JobListingHomePageState() {
    getJobListings();
  }

  void getJobListings() async {
    listingCards = [];
    try {
      await Firebase.initializeApp();
      await FirebaseFirestore.instance
          .collection('Jobs')
          .get()
          .then((snapshot) {
        if (snapshot.docs != null && snapshot.docs.length > 0) {
          snapshot.docs.forEach(
            (document) {
              listingCards.add(getCard(
                  'at ' + document.data()['company'],
                  document.data()['description'],
                  document.data()['imageURL'],
                  document.data()['location'],
                  document.data()['rate'],
                  document.data()['rating'].toDouble(),
                  document.data()['title'],
                  context));
            },
          );
        } else {
          throw Exception;
        }
        setState(() {});
      });
    } catch (e) {
      if (listingCards.isEmpty) {
        listingCards.add(getCard(
            'No Connection or no records in firebase. Try refreshing',
            '',
            'https://image.shutterstock.com/image-vector/no-wifi-sign-icon-260nw-562588744.jpg',
            '',
            '',
            5.0,
            '',
            context));
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'go Back',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: ListView(
          children: <Widget>[
            ...listingCards,
          ],
        ),
      ),
    );
  }
}
