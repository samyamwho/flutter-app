// ignore_for_file: prefer_const_constructors, must_be_immutable, use_build_context_synchronously
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:team_rescue_routes/AllScreens/mainscreen.dart';
import 'package:team_rescue_routes/AllScreens/registration_Screen.dart';
import 'package:team_rescue_routes/main.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen = "login";
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 220, 243),
      body: SingleChildScrollView(
        // Add SingleChildScrollView here
        child: Column(
          children: [
            SizedBox(
              height: 0.0,
            ),
            Image(
              image: AssetImage("images/logo.png"),
              width: 350.0,
              height: 350.0,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 1.0,
                  ),
                  TextField(
                    controller: emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "Usename",
                      labelStyle: TextStyle(fontSize: 14.0),
                      hintStyle: TextStyle(
                        color: Colors.purpleAccent,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    controller: passwordTextEditingController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(fontSize: 14.0),
                      hintStyle: TextStyle(
                        color: Colors.purpleAccent,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFAD88BA)),
                    ),
                    child: SizedBox(
                      height: 50.0,
                      width: 50.0,
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (passwordTextEditingController.text.length < 6) {
                        displayToastMessage(
                            "password must be 6 characters", context);
                      } else {
                        loginAndAuthenticateUser(context);
                        Navigator.pushNamedAndRemoveUntil(
                            context, MainScreen.idScreen, (route) => false);
                      }
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 223, 0, 0)),
                    ),
                    child: SizedBox(
                      height: 50.0,
                      width: 150.0,
                      child: Center(
                        child: Text(
                          "Emergency SOS",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, MainScreen.idScreen, (route) => false);
                    },
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, RegistrationScreen.idScreen, (route) => false);
              },
              child: Text(
                "Dont have an account? Register Here",
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async {
    final User? firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            // ignore: body_might_complete_normally_catch_error
            .catchError((errMsg) {
      // ignore: prefer_interpolation_to_compose_strings
      displayToastMessage("Error" + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) //user created
    {
      usersRef.child(firebaseUser.uid).once().then((DataSnapshot snap) {
            if (snap.value != null) {
              Navigator.pushNamedAndRemoveUntil(
                  context, MainScreen.idScreen, (route) => false);
              displayToastMessage(
                  "Yayyyyyy, you have logged in successfully", context);
            } else {
              _firebaseAuth.signOut();
              displayToastMessage(
                  "no records font, please create new account", context);
            }
          } as FutureOr Function(DatabaseEvent value));
    } else {
      displayToastMessage("Cannot sign in ", context);
    }
  }
}

// This is an update
// git add .
// git commit -m"login screen finished"
// git push -u origin main
// Hello world
// stuck
// i am stuck
// hello hello
// samyam
// nischal