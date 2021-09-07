import 'package:flutter/material.dart';
import 'package:one_life/Screens/Start/startup_screen.dart';
import 'package:one_life/components/rounded_button.dart';

class SorryAlert extends StatelessWidget {
  const SorryAlert({Key key}) : super(key: key);

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
              "assets/images/sorry.png",
              width: size.width * 0.65,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              "You are not Eligible for donating blood to others",
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
              text: " CONTINUE ",
              press: () {
                Navigator.push(
                  // if pressed leads to profile screen
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
