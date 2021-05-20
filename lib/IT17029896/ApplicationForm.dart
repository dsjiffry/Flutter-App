import 'package:assignment_2021_jun_we_12/IT17029896/JobListings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:assignment_2021_jun_we_12/IT17029896/CustomWidgets.dart';

void main() {
  runApp(ApplicationForm());
}

class ApplicationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]); //Make app fullscreen
    return MaterialApp(
      title: 'Application Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Application Form',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

enum radioList { high_school, associate, bachelor, master, doctorate, none }

class MyHomePageState extends State<MyHomePage> with CustomWidgets {
  radioList _character = radioList.high_school;
  @override
  Widget build(BuildContext context) {
    var radioOptions = <ListTile>[];

    for (var each in radioList.values) {
      String name;
      if (each == radioList.high_school) {
        name = "High School";
      } else if (each != radioList.none) {
        name = each.toString().replaceAll("radioList.", "") + "\'s";
        name = name[0].toUpperCase() + name.substring(1);
      } else {
        name = each.toString().replaceAll("radioList.", "");
      }

      radioOptions.add(ListTile(
        title: Text(name),
        leading: Radio<radioList>(
          value: each,
          groupValue: _character,
          onChanged: (radioList value) {
            setState(() {
              _character = value;
            });
          },
        ),
      ));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'go Back',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JobListings()),
              );
            },
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            ListTile(
              title: getTextWidget(
                  "Full Name", 15, 0, FontWeight.normal, Colors.black54),
              trailing: getTextFormField(220.0, "Full Name", Icons.face,
                  mainColor: Colors.black54),
            ),
            ListTile(
                title: getTextWidget(
                    "Address", 15, 0, FontWeight.normal, Colors.black54),
                trailing: getTextFormField(220.0, "Address", Icons.gps_fixed,
                    mainColor: Colors.black54)),
            ListTile(
                title: getTextWidget(
                    "Email", 15, 0, FontWeight.normal, Colors.black54),
                trailing: getTextFormField(220.0, "Email", Icons.email,
                    mainColor: Colors.black54)),
            ListTile(
                title: getTextWidget(
                    "Phone", 15, 0, FontWeight.normal, Colors.black54),
                trailing: getTextFormField(220.0, "Phone", Icons.phone,
                    mainColor: Colors.black54)),
            ListTile(
                title: getTextWidget("\nYour highest level of education:", 15,
                    0, FontWeight.normal, Colors.black)),
            ListTile(
                title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[...radioOptions],
            )),
            ListTile(
                title: getTextWidget(
                    "Link to CV", 15, 0, FontWeight.normal, Colors.black54),
                trailing: getTextFormField(220.0, "CV link", Icons.work,
                    mainColor: Colors.black54)),
            ListTile(
                trailing: getOutlinedButton("Submit", () {
              _showMyDialog();
            }, backgroundColor: Colors.transparent, borderColor: Colors.blue)),
          ],
        ));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Your application has been submitted'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JobListings()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
