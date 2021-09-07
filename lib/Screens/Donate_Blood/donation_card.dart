import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class DonationCard extends StatefulWidget {
  DonationCard(this.name, this.address, this.postCode, this.phone, this.gender,
      this.bloodType, this.quantity, this.userId,
      {this.key});
  final Key key;
  final String name;
  final String address;
  final String postCode;
  final String phone;
  final String gender;
  final String bloodType;
  final String quantity;
  final String userId;

  @override
  _DonationCardState createState() => _DonationCardState();
}

class _DonationCardState extends State<DonationCard> {
  //connects to phone call
  void phoneNumberLaunch(number) async {
    if (await canLaunch(number)) {
      await launch(number);
    } else {
      print(' could not launch $number');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userId)
            .snapshots(),
        builder: (ctx, snapShot) {
          final doc = snapShot.data;
          if (snapShot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          return Card(
            shadowColor: Theme.of(context).primaryColor,
            elevation: 5,
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple[100],
                    foregroundColor: Colors.black,
                    backgroundImage: doc['image_url'] != ''
                        ? NetworkImage(doc['image_url'])
                        : null,
                    radius: 30,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.name),
                      RaisedButton(
                        onPressed: () {
                          phoneNumberLaunch('tel:' + widget.phone);
                        },
                        child: Text('Donate'),
                        color: Colors.green[300],
                        elevation: 5,
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.address + ', ' + widget.postCode),
                          Container(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text('Blood Type '),
                              CircleAvatar(
                                radius: 15,
                                child: Text(widget.bloodType),
                              ),
                              Text(' Bag Needs '),
                              CircleAvatar(
                                radius: 15,
                                child: Text(widget.quantity),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }
}
