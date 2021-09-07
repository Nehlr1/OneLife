import 'package:flutter/material.dart';
import 'package:one_life/Screens/Donor_Eligibility/components/question_three.dart';
import 'package:one_life/Screens/Donor_Eligibility/components/sorry_alert.dart';
import 'package:one_life/components/rounded_button.dart';

class QuestionTwo extends StatelessWidget {
  const QuestionTwo({Key key}) : super(key: key);

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
              "assets/images/question_2.png",
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              "Are you over 75 years old ? ",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedButton(
              // Customizd  Yes button
              text: " YES ",
              press: () {
                Navigator.push(
                  // if pressed leads to profile screen
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SorryAlert();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              // Customizd No button
              text: " NO ",
              press: () {
                Navigator.push(
                  // if pressed leads to question two screen
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return QuestionThree();
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
