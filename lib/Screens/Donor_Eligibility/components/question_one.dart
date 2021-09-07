import 'package:flutter/material.dart';
import 'package:one_life/Screens/Donor_Eligibility/components/question_two.dart';
import 'package:one_life/Screens/Donor_Eligibility/components/sorry_alert.dart';
import 'package:one_life/components/rounded_button.dart';

class QuestionOne extends StatelessWidget {
  const QuestionOne({Key key}) : super(key: key);

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
              "assets/images/question_1.png",
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              "Are you under 18 years old ? ",
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
                // if pressed leads to profile screen
                Navigator.push(
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
                      return QuestionTwo();
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
