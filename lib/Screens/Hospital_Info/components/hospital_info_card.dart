import 'package:flutter/material.dart';

class HospitalInfoCard extends StatefulWidget {
  final String name;
  final String address;
  final String markID;
  final String phone;
  final String longitude;
  final String latitude;
  final Function mobilePress;
  final String mapText;
  final Function mapPress;
  const HospitalInfoCard({
    Key key,
    this.name,
    this.address,
    this.markID,
    this.phone,
    this.longitude,
    this.latitude,
    this.mobilePress,
    this.mapText,
    this.mapPress,
  }) : super(key: key);

  @override
  _HospitalInfoCardState createState() => _HospitalInfoCardState();
}

class _HospitalInfoCardState extends State<HospitalInfoCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.all(8),
            leading: Icon(
              Icons.add_location_outlined,
              color: Colors.red,
            ),
            title: Text(
              widget.name,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8, right: 8),
              child: Text(
                widget.address,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: widget.mobilePress,
                child: Text(
                  widget.phone,
                ),
              ),
              TextButton(
                onPressed: widget.mapPress,
                child: Text(
                  widget.mapText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
