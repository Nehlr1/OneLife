import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:one_life/components/rounded_button.dart';
import 'adminPanel.dart';

class HospitalRegister extends StatefulWidget {
  HospitalRegister({Key key}) : super(key: key);

  @override
  _HospitalRegisterState createState() => _HospitalRegisterState();
}

class _HospitalRegisterState extends State<HospitalRegister> {
  String _name;
  String _address;
  String _phoneNumber;
  String _markID;
  String _latitude;
  String _longitude;
  bool _isSubmitted = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: " Name "),
      validator: (String value) {
        if (value.isEmpty) {
          return "Name is Required";
        }
        return null;
      },
      onSaved: (String value) {
        setState(() {
          _name = value;
        });
      },
    );
  }

  Widget buildAddress() {
    return TextFormField(
      decoration: InputDecoration(labelText: " Address "),
      validator: (String value) {
        if (value.isEmpty) {
          return "Address is Required";
        }
        return null;
      },
      onSaved: (String value) {
        setState(() {
          _address = value;
        });
      },
    );
  }

  Widget buildZipCode() {
    return TextFormField(
      decoration: InputDecoration(labelText: " Mark ID "),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return "Mark ID is Required";
        }
        return null;
      },
      onSaved: (String value) {
        setState(() {
          _markID = value;
        });
      },
    );
  }

  Widget buildPhoneNumber() {
    return TextFormField(
      decoration: InputDecoration(labelText: " Phone Number "),
      keyboardType: TextInputType.phone,
      validator: (String value) {
        if (value.isEmpty) {
          return "Phone Number is Required";
        }
        return null;
      },
      onSaved: (String value) {
        setState(() {
          _phoneNumber = value;
        });
      },
    );
  }

  Widget buildGender() {
    return TextFormField(
      decoration: InputDecoration(labelText: " Latitude "),
      validator: (value) {
        if (value.isEmpty) {
          return "Latitude is Required";
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          _latitude = value;
        });
      },
    );
  }

  Widget buildBloodType() {
    return TextFormField(
      decoration: InputDecoration(labelText: " Logitude "),
      validator: (value) {
        if (value.isEmpty) {
          return "Logitude is Required";
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          _longitude = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Hospital"),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(30),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildName(),
                buildAddress(),
                buildZipCode(),
                buildPhoneNumber(),
                buildGender(),
                buildBloodType(),
                SizedBox(
                  height: 50,
                ),
                RoundedButton(
                  text: "Submit",
                  press: () async {
                    if (formKey.currentState.validate()) {
                      //return;
                      formKey.currentState.save();
                      try {
                        await FirebaseFirestore.instance
                            .collection('hospitals')
                            .add({
                          'name': _name,
                          'address': _address,
                          'markId': _markID,
                          'phone': _phoneNumber,
                          'logitude': _longitude,
                          'latitude': _latitude,
                          'hos_id': FirebaseAuth.instance.currentUser.uid,
                        }).then((_) {
                          setState(() {
                            _isSubmitted = true;
                          });
                        }).catchError(
                                (error) => print("Failed to add hospital: $error"));
                      } catch (err) {
                        print(err);
                      }
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return AdminPanel();
                      }),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
