import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ViewDetails extends StatefulWidget {
  @override
  _ViewDetailsState createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  var userdata = [];
  var keyData = [
    "Name",
    "DOB",
    "Age",
    "Gender",
    "Blood Group",
    "Height",
    "Weight",
    "Genetic Disease",
    "Chronic Disease",
    "Allergies"
  ];

  @override
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref
        .child("Users")
        .child('321321321321')
        .child('Details')
        .once()
        .then((DataSnapshot snap) {
      var user = snap.value;
      userdata.clear();
      for (var key in keyData) {
        userdata.add('$key : ${user[key]}');
      }
      //user.forEach((val) => userdata.add(val.toString()));
      //userdata = user.map((val) => val.toString()).toList();
      print('Data : ${user}');
      //print('keys : ${keys}');
      setState(() {
        print('Length: ${userdata.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          child: userdata.length == 0
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Data loading...'),
                  ],
                ))
              : ListView.builder(
                  itemCount: userdata.length,
                  itemBuilder: (context, pos) {
                    return Card(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        child: Text(
                          userdata[pos],
                          style: TextStyle(
                            fontSize: 18.0,
                            height: 1.6,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
