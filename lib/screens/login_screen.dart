import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../authentication/authentication.dart';
import '../constants/api_constants.dart';
import '../widgets/rounded_button.dart';
import 'my_homePage.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              Hero(
                tag: 'logo',
                child: Container(
                  height: 100.0,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              SizedBox(
                height: 30.0,
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
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.lightBlueAccent,
                onPressed: () async {
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, MyHomePage.id);
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'account-exists-with-different-credential') {
                      setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                          Authentication.customSnackBar(
                            content:
                                'The account already exists with a different credential',
                          ),
                        );
                      });
                    } else if (e.code == 'invalid-credential') {
                      setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                          Authentication.customSnackBar(
                            content:
                                'Error occurred while accessing credentials. Try again.',
                          ),
                        );
                      });
                    }
                  } catch (e) {
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        Authentication.customSnackBar(
                          content: 'Error occurred Signing In. Try again.',
                        ),
                      );
                    });
                  }
                },
                title: Text(
                  'Log In',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
