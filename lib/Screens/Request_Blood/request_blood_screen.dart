import 'package:flutter/material.dart';
import 'package:one_life/Screens/Request_Blood/components/request_blood_form.dart';

class RequestBloodScreen extends StatelessWidget {
  const RequestBloodScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        
        label: Text('Request Blood'),
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return RequestBloodForm();
            }),
          );
        },
      ),
    );
    // return Scaffold(
    //   body: Container(
    //     alignment: Alignment.center,
    //     margin: EdgeInsets.all(20),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         RoundedButton(
    //           text: " Request Blood ",
    //           press: () {
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) {
    //                   return RequestBloodForm();
    //                 },
    //               ),
    //             );
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
