import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'components/hospital_card.dart';

class HospitalScreen extends StatefulWidget {
  HospitalScreen({Key key}) : super(key: key);
  @override
  _HospitalScreenState createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('hospitals').snapshots(),
        builder: (ctx, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (chatSnapshot.data == null)
            return Center(
              child: Text('No Hospital Added'),
            );
          final chatDocs = chatSnapshot.data.documents;
          return Scaffold(
            appBar: AppBar(
              title: Text('Hospitals'),
            ),
            body: Container(
              child: ListView.builder(
                itemCount: chatDocs.length,
                itemBuilder: (ctx, index) => HospitalCard(
                  chatDocs[index]['name'],
                  chatDocs[index]['phone'],
                  chatDocs[index]['hos_id'],
                  //key: ValueKey(chatDocs[index].documentID),
                ),
              ),
            ),
          );
        });
  }
}
