import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class NearbyHospital extends StatefulWidget {
  @override
  _NearbyHospitalState createState() => _NearbyHospitalState();
}

class _NearbyHospitalState extends State<NearbyHospital> {
  var hospitals = [];

  @override
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('Hospitals').once().then((DataSnapshot snap) {
      var data = snap.value;
      print('Data : ${data}');
      hospitals.clear();
      for (var val in data) {
        hospitals.add(val);
      }
      setState(() {
        print('Length: ${hospitals.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Hospitals',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 8),
          child: hospitals.length == 0
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Text('Data loading...'),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: hospitals.length,
                  itemBuilder: (context, pos) {
                    return Padding(
                        padding:
                            EdgeInsets.only(bottom: 6.0, left: 10, right: 8),
                        child: Card(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 14.0, horizontal: 16.0),
                            child: Text(
                              hospitals[pos],
                              style: TextStyle(
                                fontSize: 18.0,
                                //height: 1,
                              ),
                            ),
                          ),
                        ));
                  },
                ),
        ),
      ),
    );
  }
}
