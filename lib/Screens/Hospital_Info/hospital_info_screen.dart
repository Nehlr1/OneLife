import 'package:flutter/material.dart';
import 'package:one_life/Screens/Hospital_Info/components/hospital_info_card.dart';
import 'package:one_life/Screens/Hospital_Info/components/hospital_map.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// root of Hospital INFO Screen
class HospitalInfoScreen extends StatefulWidget {
  HospitalInfoScreen({Key key}) : super(key: key);

  @override
  _HospitalInfoScreenState createState() => _HospitalInfoScreenState();
}

class _HospitalInfoScreenState extends State<HospitalInfoScreen> {
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
          return ListView.builder(
            itemCount: chatDocs.length,
            itemBuilder: (ctx, index) => HospitalInfoCard(
              name: chatDocs[index]['name'],
              address: chatDocs[index]['address'],
              markID: chatDocs[index]['markId'],
              phone: chatDocs[index]['phone'],
              longitude: chatDocs[index]['logitude'],
              latitude: chatDocs[index]['latitude'],
              mobilePress: () {
                phoneNumberLaunch('tel:' + chatDocs[index]['phone']);
              },
              mapText: 'Show in Map',
              mapPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HospitalMap();
                    },
                  ),
                );
              },
            ),
          );
        });
  }
}
