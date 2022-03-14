import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:movies_app_gee/screens/registration_screen.dart';

import '../widgets/rounded_button.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    animation =
        ColorTween(begin: Colors.grey, end: Colors.white).animate(controller);

    controller.forward();

    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

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
              Row(
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('assets/images/logo.png'),
                      height: 60.0,
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  DefaultTextStyle(
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Agne',
                    ),
                    child: Expanded(
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            'Movie App',
                            speed: Duration(milliseconds: 300),
                          ),
                        ],
                      ),
                    ),
                  )
                  // Text(
                  //   'Flash Chat',
                  //   style: TextStyle(
                  //     color: Colors.blueGrey,
                  //     fontSize: 45.0,
                  //     fontWeight: FontWeight.w900,
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              RoundedButton(
                color: Colors.lightBlueAccent,
                title: Text(
                  'Sign in with email',
                ),
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                  //Go to login screen.
                },
              ),
              // RoundedButton(
              //   color: Colors.lightBlueAccent,
              //   title: Text(
              //     'Sign in with google',
              //   ),
              //   onPressed: () {
              //     Navigator.pushNamed(context, SignInScreen.id);
              //     //Go to login screen.
              //   },
              // ),
              RoundedButton(
                color: Colors.blueAccent,
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                title: Text(
                  'Create an account',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
