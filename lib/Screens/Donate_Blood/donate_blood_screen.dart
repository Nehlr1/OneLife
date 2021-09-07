import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:one_life/Screens/Donate_Blood/donation_card.dart';
import 'package:one_life/Screens/Donor_Eligibility/donor_eligibility.dart';

class DonateBloodScreen extends StatefulWidget {
  DonateBloodScreen({Key key}) : super(key: key);

  @override
  _DonateBloodScreenState createState() => _DonateBloodScreenState();
}

class _DonateBloodScreenState extends State<DonateBloodScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .snapshots(),
      builder: (ctx, snapShot) {
        if (snapShot.data == null) return CircularProgressIndicator();
        final doc = snapShot.data;
        return doc['is_Donor'] == true
            ? StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('bloodAdvertises')
                    .where('user_id',
                        isNotEqualTo: FirebaseAuth.instance.currentUser.uid)
                    .snapshots(),
                builder: (ctx, chatSnapshot) {
                  if (chatSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (chatSnapshot.data == null)
                    return Center(
                      child: Text('No One Need Blood Donation'),
                    );
                  final chatDocs = chatSnapshot.data.documents;
                  return ListView.builder(
                    itemCount: chatDocs.length,
                    itemBuilder: (ctx, index) => DonationCard(
                      chatDocs[index]['name'],
                      chatDocs[index]['address'],
                      chatDocs[index]['postalCode'],
                      chatDocs[index]['phone'],
                      chatDocs[index]['gender'],
                      chatDocs[index]['bloodType'],
                      chatDocs[index]['bloodQuantity'],
                      chatDocs[index]['user_id'],
                      key: ValueKey(chatDocs[index].documentID),
                    ),
                  );
                })
            : Center(
                child: FlatButton(
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text('Become Donor'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return DonorEligibility();
                      }),
                    );
                  },
                ),
              );
      },
    );
  }
}
