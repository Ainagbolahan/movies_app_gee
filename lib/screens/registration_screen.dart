import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../authentication/authentication.dart';
import '../constants/api_constants.dart';
import '../widgets/rounded_button.dart';
import 'my_homePage.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 122.0,
                child: Image.asset('assets/images/logo.png'),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                  //Do something with the user input.
                },
                decoration: kMessageTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                  enabledBorder: kTextFieldDecoration.enabledBorder?.copyWith(
                    borderSide:
                        kTextFieldDecoration.enabledBorder?.borderSide.copyWith(
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                  //Do something with the user input.
                },
                decoration: kMessageTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                  enabledBorder: kTextFieldDecoration.enabledBorder?.copyWith(
                    borderSide:
                        kTextFieldDecoration.enabledBorder?.borderSide.copyWith(
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              RoundedButton(
                title: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  //Implement registration functionality.
                  try {
                    final UserCredential newUser =
                        await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, MyHomePage.id);
                    }
                  } catch (e) {
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        Authentication.customSnackBar(
                          content: 'Error occurred Signing up. Try again.',
                        ),
                      );
                    });
                  }
                },
                color: Colors.blueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
