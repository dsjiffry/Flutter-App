import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/home_page.dart';
import 'constants.dart';
import 'colors.dart';
import 'login_screen.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String _name, _email, _password; //local variables

  void registerUser(BuildContext context) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: _email, password: _password)
        .catchError((onError) {
      //print(onError);
    }).then((authUser) {
      print(authUser.user.uid);
      if (authUser.user != null)
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Image.asset(
                      bgImage,
                      height: height * 0.25, //0/3
                      width: width,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: height * 0.32, //42
                      width: width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            stops: [0.2, 0.75],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.grey.shade300]),
                      ),
                      //color: Colors.cyan.withOpacity(0.3),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 0,
                      right: 0,
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              registerPage,
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.blue.shade900),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20),
                  child: Container(
                      child: Text("  $register  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              secondColor.withOpacity(0.2),
                              Colors.transparent,
                            ],
                          ),
                          border: Border(
                              left: BorderSide(color: secondColor, width: 5)))),
                ),

                //name

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: TextFormField(
                    onChanged: (value) {
                      _name = value;
                    },
                    validator: (namevalue) {
                      if (namevalue!.isEmpty) return "Please enter name";
                      // else if (!RegExp(
                      //         r"[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                      //     .hasMatch(namevalue))
                      //   return "Its not a valid email ID";

                      return null;
                    },
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: secondColor)),
                        prefixIcon: Icon(Icons.text_fields, color: secondColor),
                        labelText: "NAME",
                        labelStyle:
                            TextStyle(color: secondColor, fontSize: 12)),
                  ),
                ),

                //email
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: TextFormField(
                    onChanged: (value) {
                      _email = value;
                    },
                    validator: (emailvalue) {
                      if (emailvalue!.isEmpty)
                        return "Please enter email";
                      else if (!RegExp(
                              r"[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                          .hasMatch(emailvalue))
                        return "Its not a valid email ID";

                      return null;
                    },
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: secondColor)),
                        prefixIcon: Icon(Icons.email, color: secondColor),
                        labelText: "EMAIL ADDRESS",
                        labelStyle:
                            TextStyle(color: secondColor, fontSize: 12)),
                  ),
                ),

                //password
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: TextFormField(
                    onChanged: (value) {
                      _password = value;
                    },
                    validator: (password) {
                      if (password!.isEmpty)
                        return "Please enter password";
                      else if (password.length < 8 || password.length > 15)
                        return "Password length should between 8-15";
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: secondColor)),
                        prefixIcon: Icon(Icons.lock_open, color: secondColor),
                        labelText: "PASSWORD",
                        labelStyle:
                            TextStyle(color: secondColor, fontSize: 12)),
                  ),
                ),

                Center(
                  child: SizedBox(
                    height: height * 0.08,
                    width: width - 100,
                    child: RaisedButton(
                      color: secondColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          registerUser(context);
                        }
                        // setState(() {
                        //   showProgress = true;
                        // });
                        // try {
                        //   final newuser =
                        //       await _auth.createUserWithEmailAndPassword(
                        //           email: _email, password: _password);
                        //   if (newuser != null) {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => HomePage()),
                        //     );
                        //     setState(() {
                        //       showProgress = false;
                        //     });
                        //   }
                        // } catch (e) {}
                      },
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
