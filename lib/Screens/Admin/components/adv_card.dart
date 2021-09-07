import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdvCard extends StatefulWidget {
  AdvCard(this.name, this.bloodType, this.advId, {this.key});
  final Key key;
  final String name;
  final String bloodType;
  final String advId;
  @override
  _AdvCardState createState() => _AdvCardState();
}

class _AdvCardState extends State<AdvCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Theme.of(context).primaryColor,
      elevation: 5,
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 5,
        ),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.name),
            Text(widget.bloodType),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("bloodAdvertises")
                    .where("user_id", isEqualTo: widget.advId)
                    .get()
                    .then((value) {
                  value.docs.forEach((element) {
                    FirebaseFirestore.instance
                        .collection("bloodAdvertises")
                        .doc(element.id)
                        .delete()
                        .then((value) {
                      print("Success!");
                    });
                  });
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
