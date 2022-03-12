import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movies_app_gee/screens/login_screen.dart';
import 'package:movies_app_gee/screens/my_homePage.dart';
import 'package:movies_app_gee/screens/registration_screen.dart';
import 'package:movies_app_gee/screens/welcome_screen.dart';
import 'package:movies_app_gee/theme/theme_state.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeState>(
      create: (_) => ThemeState(),
      child: MaterialApp(
          title: 'Movie App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.blue, canvasColor: Colors.transparent),
          // home: MyHomePage(),
          initialRoute: WelcomeScreen.id,
          routes: {
            WelcomeScreen.id: (context) => WelcomeScreen(),
            LoginScreen.id: (context) => LoginScreen(),
            RegistrationScreen.id: (context) => RegistrationScreen(),
            MyHomePage.id: (context) => MyHomePage(),
            // SignInScreen.id: (context) => SignInScreen(),
          }),
    );
  }
}
