import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pix_health/pages/appointment_data.dart';

class FurtherAppointment extends StatefulWidget {
  @override
  _FurtherAppointmentState createState() => _FurtherAppointmentState();
}

class _FurtherAppointmentState extends State<FurtherAppointment> {
  List<AppointmentData> allData = [];

  Widget UI(String date, String checkup, String doctor, String hospital) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        elevation: 10.0,
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Checkup : $checkup',
                style: Theme.of(context).textTheme.title,
              ),
              Text('Date : $date'),
              Text('Doctor : $doctor'),
              Text('Hospital : $hospital'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref
        .child("Users")
        .child('321321321321')
        .child('Appointments')
        .once()
        .then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      allData.clear();
      for (var key in keys) {
        AppointmentData d = AppointmentData(data[key]['Date'],
            data[key]['Checkup'], data[key]['Doctor'], data[key]['Hospital']);
        allData.add(d);
      }
      setState(() {
        print('Length: ${allData.length}');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Appointments',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          child: allData.length == 0
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Data loading...'),
                  ],
                ))
              : ListView.builder(
                  itemCount: allData.length,
                  itemBuilder: (_, index) {
                    return UI(allData[index].date, allData[index].checkup,
                        allData[index].doctor, allData[index].hospital);
                  },
                ),
        ),
      ),
    );
  }
}
