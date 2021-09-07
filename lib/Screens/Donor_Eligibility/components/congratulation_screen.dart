import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:one_life/Screens/Start/startup_screen.dart';
import 'package:one_life/components/rounded_button.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provides the total height and width of the screen
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/congrats.png",
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              "Congratulations. You are eligible to give blood. ",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              "Every donation can save 3 lives",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedButton(
              // Customizd Take a Quiz button
              text: "Continue",
              press: () async {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser.uid)
                    .update({'is_Donor': true});
                Navigator.push(
                  // if pressed, leads to Start up screen
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return StartUp();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
