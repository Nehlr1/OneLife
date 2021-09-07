import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:one_life/Screens/Start/startup_screen.dart';
import 'package:one_life/components/rounded_button.dart';

class RequestBloodForm extends StatefulWidget {
  RequestBloodForm({Key key}) : super(key: key);

  @override
  _RequestBloodFornState createState() => _RequestBloodFornState();
}

class _RequestBloodFornState extends State<RequestBloodForm> {
  String _name;
  String _address;
  String _postalCode;
  String _phoneNumber;
  String _gender;
  String _bloodType;
  String _bag;
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
      decoration: InputDecoration(labelText: " Postal Code "),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return "Postal Code is Required";
        }
        return null;
      },
      onSaved: (String value) {
        setState(() {
          _postalCode = value;
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
      decoration: InputDecoration(labelText: " Gender "),
      validator: (String value) {
        if (value.isEmpty) {
          return "Gender is Required";
        }
        return null;
      },
      onSaved: (String value) {
        setState(() {
          _gender = value;
        });
      },
    );
  }

  Widget buildBloodType() {
    return TextFormField(
      decoration: InputDecoration(labelText: " Blood Type "),
      validator: (String value) {
        if (value.isEmpty) {
          return "Blood Type is Required";
        }
        return null;
      },
      onSaved: (String value) {
        setState(() {
          _bloodType = value;
        });
      },
    );
  }

  Widget buildBloodBag() {
    return TextFormField(
      decoration: InputDecoration(labelText: " Quantity (In Bags) "),
      validator: (String value) {
        if (value.isEmpty) {
          return "Quantity is Required";
        }
        return null;
      },
      onSaved: (String value) {
        setState(() {
          _bag = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Request Blood"),
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
                buildBloodBag(),
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
                            .collection('bloodAdvertises')
                            .add({
                          'name': _name,
                          'address': _address,
                          'postalCode': _postalCode,
                          'phone': _phoneNumber,
                          'gender': _gender,
                          'bloodType': _bloodType,
                          'bloodQuantity': _bag,
                          'user_id': FirebaseAuth.instance.currentUser.uid,
                        }).then((_) {
                          setState(() {
                            _isSubmitted = true;
                          });
                        }).catchError(
                                (error) => print("Failed to add user: $error"));
                      } catch (err) {
                        print(err);
                      }
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return StartUp();
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
