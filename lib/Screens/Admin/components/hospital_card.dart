import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HospitalCard extends StatefulWidget {
  HospitalCard(this.name, this.phone, this.hosId, {this.key});
  final Key key;
  final String name;
  final String phone;
  final String hosId;
  @override
  _HospitalCardState createState() => _HospitalCardState();
}

class _HospitalCardState extends State<HospitalCard> {
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
            Text(widget.phone),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("hospitals")
                    .where("hos_id", isEqualTo: widget.hosId)
                    .get()
                    .then((value) {
                  value.docs.forEach((element) {
                    FirebaseFirestore.instance
                        .collection("hospitals")
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
