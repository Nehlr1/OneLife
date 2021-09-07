import 'package:flutter/material.dart';
import 'package:one_life/Screens/Donor_Eligibility/components/question_six.dart';
import 'package:one_life/Screens/Donor_Eligibility/components/sorry_alert.dart';
import 'package:one_life/components/rounded_button.dart';

class QuestionFive extends StatelessWidget {
  const QuestionFive({Key key}) : super(key: key);

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
              "assets/images/question_5.png",
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              "Have a heart condition ? ",
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
                  // if pressed leads to question six screen
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return QuestionSix();
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
