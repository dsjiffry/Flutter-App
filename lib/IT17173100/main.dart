import 'package:flutter/material.dart';
import 'package:assignment_2021_jun_we_12/IT17173100/screens/qa_screen.dart';
import 'package:assignment_2021_jun_we_12/IT17173100/screens/qas_screen.dart';
import 'package:assignment_2021_jun_we_12/IT17029896/JobListings.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: QAsScreen.routeName,
      onGenerateRoute: (RouteSettings settings) {
        var routes = <String, WidgetBuilder>{
          QAsScreen.routeName: (context) => QAsScreen(),
          QAScreen.routeName: (context) => QAScreen(settings.arguments)
        };
        WidgetBuilder builder = routes[settings.name];
        ThemeData(
          primarySwatch: Colors.blue,
        );
        return MaterialPageRoute(builder: (ctx) => builder(ctx));
      },
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JobListings()),
                );
              },
              child: const Text('View Job Listings'),
            ),
          ],
        ),
      ),
    );
  }
}
