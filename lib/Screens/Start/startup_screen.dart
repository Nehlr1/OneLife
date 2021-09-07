import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:one_life/Screens/Admin/adminPanel.dart';
import 'package:one_life/Screens/Donate_Blood/donate_blood_screen.dart';
import 'package:one_life/Screens/Hospital_Info/hospital_info_screen.dart';
import 'package:one_life/Screens/Profile/components/user_information.dart';
import 'package:one_life/Screens/Request_Blood/components/request_blood_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:one_life/Screens/Signup/signup_screen.dart';
import 'package:one_life/Screens/Donor_Eligibility/donor_eligibility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StartUp extends StatefulWidget {
  StartUp({Key key}) : super(key: key);

  @override
  _StartUpState createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> {
  @override
  Widget build(BuildContext context) {
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
          if (!snapshots.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final doc = snapshots.data;
          return doc['is_Admin'] == true
              ? AdminPanel()
              : DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    floatingActionButton: SpeedDial(
                      backgroundColor: Theme.of(context).primaryColor,
                      animatedIcon: AnimatedIcons.menu_close,
                      children: [
                        SpeedDialChild(
                          backgroundColor: Colors.red,
                          child: Icon(
                            Icons.exit_to_app,
                          ),
                          label: 'Logout',
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return SignUpScreen();
                                },
                              ),
                            );
                          },
                        ),
                        SpeedDialChild(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(Icons.person),
                          label: 'View Profile',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return Scaffold(
                                  body: ListView(
                                    children: [
                                      UserInformation(),
                                    ],
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                        SpeedDialChild(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(
                            Icons.add,
                          ),
                          label: 'Request Blood',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return RequestBloodForm();
                              }),
                            );
                          },
                        ),
                        SpeedDialChild(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Icon(Icons.face),
                          label: 'Become Donor',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return DonorEligibility();
                              }),
                            );
                          },
                        ),
                      ],
                    ),
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      title: Text("OneLife"),
                      centerTitle: true,
                      bottom: TabBar(
                        tabs: [
                          Tab(
                            child: Text("HOSPITAL INFO"),
                          ),
                          Tab(
                            child: Text("DONATE BLOOD"),
                          ),
                        ],
                      ),
                    ),
                    body: TabBarView(children: [
                      HospitalInfoScreen(),
                      DonateBloodScreen(),
                    ]),
                  ),
                );
        });
  }
}
