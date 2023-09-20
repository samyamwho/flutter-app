// ignore_for_file: prefer_const_constructors, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:team_rescue_routes/AllScreens/login_screen.dart';
import 'package:team_rescue_routes/AllScreens/mainscreen.dart';
import 'package:team_rescue_routes/main.dart';

// ignore: must_be_immutable
class RegistrationScreen extends StatelessWidget {
  static const String idScreen = "register";
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                    controller: nameTextEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(fontSize: 14.0),
                      hintStyle: TextStyle(
                        color: Colors.purpleAccent,
                        fontSize: 10.0,
                      ),
                    ),
                  ),
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
                    height: 1.0,
                  ),
                  TextField(
                    controller: phoneTextEditingController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Phone",
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
                          "create",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (nameTextEditingController.text.length < 2) {
                        displayToastMessage(
                            "name must be atlease 3 character", context);
                      } else if (phoneTextEditingController.text.isEmpty) {
                        displayToastMessage(
                            "phone number is mandatory", context);
                      } else if (passwordTextEditingController.text.length <
                          6) {
                        displayToastMessage(
                            "password must be 6 characters", context);
                      } else {
                        registerNewUser(context);
                      }
                    },
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginScreen.idScreen, (route) => false);
              },
              child: Text(
                "Already have an account, Login here",
                style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
   registerNewUser(BuildContext context) async {
    final User? firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) => displayToastMessage("Error:$errMsg", context)))
        .user;

    if (firebaseUser != null) //user created
    {
      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };
      usersRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage("congrats your acccount is created", context);
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.idScreen, (route) => false);
    } 
    else {
      displayToastMessage("new user has not been created", context);
    }
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
// This is an update
// git add .
// git commit -m"login screen finished"
// git push -u origin main