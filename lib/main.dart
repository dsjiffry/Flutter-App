import 'package:assignment_2021_jun_we_12/IT17029896/JobListings.dart';
import 'package:flutter/material.dart';

/**
 * References:
 * https://flutter.dev/docs/development/ui/widgets/material
 * https://flutter.dev/docs/cookbook
 * https://firebase.flutter.dev/docs/overview
 * https://pub.dev/packages/smooth_star_rating
 * https://pub.dev/packages/flutter_signin_button
 * https://stackoverflow.com/questions/46640116/make-flutter-application-fullscreen
 * https://firebase.google.com/docs/firestore
 */

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.deepPurple,
              ),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ()),
                // );
              },
              child: const Text('Login/Register (IT17160162)'),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.deepPurple,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JobListings()),
                );
              },
              child: const Text('View Job Listings (IT17029896)'),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.deepPurple,
              ),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ()),
                // );
              },
              child: const Text('Adding Job Listings (IT17163682)'),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                primary: Colors.deepPurple,
              ),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => ()),
                // );
              },
              child: const Text('App Settings (IT17173100)'),
            ),
          ],
        ),
      ),
    );
  }
}
