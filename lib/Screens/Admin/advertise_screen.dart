import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'components/adv_card.dart';

class AdvScreen extends StatefulWidget {
  AdvScreen({Key key}) : super(key: key);
  @override
  _AdvScreenState createState() => _AdvScreenState();
}

class _AdvScreenState extends State<AdvScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('bloodAdvertises').snapshots(),
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
          return Scaffold(
            appBar: AppBar(
              title: Text('Advertises'),
            ),
            body: Container(
              child: ListView.builder(
                itemCount: chatDocs.length,
                itemBuilder: (ctx, index) => AdvCard(
                  chatDocs[index]['name'],
                  chatDocs[index]['bloodType'],
                  chatDocs[index]['adv_id'],
                  //key: ValueKey(chatDocs[index].documentID),
                ),
              ),
            ),
          );
        });
  }
}
