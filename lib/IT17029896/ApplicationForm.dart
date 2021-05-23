import 'package:assignment_2021_jun_we_12/IT17029896/JobListings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
      home: ApplicationFormHomePage(
        title: 'Application Form',
      ),
    );
  }
}

class ApplicationFormHomePage extends StatefulWidget {
  ApplicationFormHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  ApplicationFormHomePageState createState() => ApplicationFormHomePageState();
}

enum radioList { high_school, associate, bachelor, master, doctorate, none }

class ApplicationFormHomePageState extends State<ApplicationFormHomePage>
    with CustomWidgets {
  radioList _character = radioList.high_school;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cvController = TextEditingController();

  ApplicationFormHomePageState() {
    _getFormData();
  }

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
              trailing: getTextFormField(
                220.0,
                "Full Name",
                Icons.face,
                fullNameController,
                mainColor: Colors.black54,
              ),
            ),
            ListTile(
                title: getTextWidget(
                    "Address", 15, 0, FontWeight.normal, Colors.black54),
                trailing: getTextFormField(
                    220.0, "Address", Icons.gps_fixed, addressController,
                    mainColor: Colors.black54)),
            ListTile(
                title: getTextWidget(
                    "Email", 15, 0, FontWeight.normal, Colors.black54),
                trailing: getTextFormField(
                    220.0, "Email", Icons.email, emailController,
                    mainColor: Colors.black54)),
            ListTile(
                title: getTextWidget(
                    "Phone", 15, 0, FontWeight.normal, Colors.black54),
                trailing: getTextFormField(
                    220.0, "Phone", Icons.phone, phoneController,
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
                trailing: getTextFormField(
                    220.0, "CV link", Icons.work, cvController,
                    mainColor: Colors.black54)),
            ListTile(
                trailing: getOutlinedButton("Submit", () {
              _submitForm(
                  addressController.text,
                  cvController.text,
                  _character,
                  emailController.text,
                  fullNameController.text,
                  phoneController.text);
            }, backgroundColor: Colors.transparent, borderColor: Colors.blue)),
          ],
        ));
  }

  Future<void> _submitForm(String address, String cvLink, radioList education,
      String email, String fullName, String phone) async {
    await Firebase.initializeApp();
    await FirebaseFirestore.instance
        .collection('form')
        .doc('VrNa6mYTElrAWQtMR3Su')
        .set({
      'address': address,
      'cvLink': cvLink,
      'education': education.toString(),
      'email': email,
      'fullName': fullName,
      'phone': phone,
    });

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

  void _getFormData() async {
    try {
      await Firebase.initializeApp();
      await FirebaseFirestore.instance
          .collection('form')
          .get()
          .then((snapshot) {
        if (snapshot.docs != null && snapshot.docs.length > 0) {
          snapshot.docs.forEach(
            (document) {
              fullNameController.text = document.data()['fullName'];
              cvController.text = document.data()['cvLink'];
              emailController.text = document.data()['email'];
              phoneController.text = document.data()['phone'];
              addressController.text = document.data()['address'];
              for (var each in radioList.values) {
                if (each.toString() == document.data()['education']) {
                  _character = each;
                }
              }
            },
          );
        }
        setState(() {});
      });
    } catch (ignored) {}
  }

  @override
  void dispose() {
    fullNameController.dispose();
    addressController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cvController.dispose();
    super.dispose();
  }
}
