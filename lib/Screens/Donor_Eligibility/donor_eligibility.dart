import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:one_life/Screens/Donor_Eligibility/components/question_one.dart';
import 'package:one_life/components/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DonorEligibility extends StatefulWidget {
  DonorEligibility({Key key}) : super(key: key);

  @override
  _DonorEligibilityState createState() => _DonorEligibilityState();
}

class _DonorEligibilityState extends State<DonorEligibility> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provides the total height and width of the screen
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (ctx, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          final doc = snapshots.data;
          return doc['is_Donor'] == false
              ? Scaffold(
                  body: Container(
                    margin: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/quiz.png",
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text(
                          "Are you the type to give blood ? ",
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
                          "Answer a few quick questions to find out if you are eligible.",
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        RoundedButton(
                          // Customizd Take a Quiz button
                          text: "Take a Quiz",
                          press: () {
                            Navigator.push(
                              // if pressed, leads to question one screen
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return QuestionOne();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )
              : Scaffold(
                  body: Center(
                    child: Text('You are a Donor'),
                  ),
                );
        });
  }
}
