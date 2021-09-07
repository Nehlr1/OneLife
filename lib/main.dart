import 'package:flutter/material.dart';
import 'package:one_life/Screens/Start/startup_screen.dart';
import 'Screens/Signup/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'One Life',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? SignUpScreen()
          : StartUp(),
    );
  }
}
