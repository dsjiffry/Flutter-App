import 'package:flutter/material.dart';
import 'package:helloworld/home_page.dart';
import 'package:helloworld/register_page.dart';
import 'constants.dart';
import 'colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String _email, _password; //local variables

  void signIn(BuildContext context) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: _email, password: _password)
        .catchError((onError) {
      //print(onError);
    }).then((authUser) {
      print(authUser.user.uid);
      if (authUser.user != null)
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
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
                      height: height * 0.40,
                      width: width,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: height * 0.42,
                      width: width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            stops: [0.2, 0.72],
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
                              appName,
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.blue.shade900),
                            ),
                            Center(
                              child: Text(slogan,
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w600)),
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
                      child: Text("  $loginName  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              primaryColor.withOpacity(0.4),
                              Colors.transparent,
                            ],
                          ),
                          border: Border(
                              left:
                                  BorderSide(color: primaryColor, width: 5)))),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: TextFormField(
                    onSaved: (value) {
                      _email = value!;
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
                            borderSide: BorderSide(color: primaryColor)),
                        prefixIcon: Icon(Icons.email, color: primaryColor),
                        labelText: "EMAIL ADDRESS",
                        labelStyle:
                            TextStyle(color: primaryColor, fontSize: 12)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: TextFormField(
                    onSaved: (value) {
                      _password = value!;
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
                            borderSide: BorderSide(color: primaryColor)),
                        prefixIcon: Icon(Icons.lock_open, color: primaryColor),
                        labelText: "PASSWORD",
                        labelStyle:
                            TextStyle(color: primaryColor, fontSize: 12)),
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                        onPressed: () {}, child: Text("Forget Password?"))),
                Center(
                  child: SizedBox(
                    height: height * 0.08,
                    width: width - 50,
                    child: FlatButton(
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          signIn(context);
                          // if (_email == "test@gmail.com" &&
                          //     _password == "root@123") {
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => HomePage(),
                          //     ),
                          //   );
                          //   FocusScope.of(context).unfocus();
                          // } else {
                          //   print("Invalid Login");
                          // }
                        }
                      },
                      child: Text(
                        "Login into Account",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account?"),
                      FlatButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
                          },
                          child: Text("Create Account",
                              style:
                                  TextStyle(color: primaryColor, fontSize: 12)))
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
