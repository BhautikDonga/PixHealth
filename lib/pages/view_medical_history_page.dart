import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pix_health/pages/image_listview.dart';
import 'package:pix_health/pages/report_data.dart';

class MedicalHistory extends StatefulWidget {
  @override
  _MedicalHistoryState createState() => _MedicalHistoryState();
}

class _MedicalHistoryState extends State<MedicalHistory> {
  List<ReportData> allData = [];
  int _currentIndex = 0;
  List<Widget> _children = [];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> _ackDocuments(BuildContext context) {
    return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)), //this right here
              child: Scaffold(
//              appBar: AppBar(
//                title: Text("hello"),
//              ),
                body: _children[_currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  onTap: onTabTapped,
                  elevation: 4,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.filter_center_focus),
                      title: Text('Reports'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.description),
                      title: Text('Prescription'),
                    ),
                  ],
                ),
              ));
        });
  }

  Widget UI(String date, String doctor, String hospital, String diagnosis,
      var report_url, var prescription_url) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: () {
          _children.clear();
          _children.add(ImageList(report_url));
          _children.add(ImageList(prescription_url));
          setState(() {
            _ackDocuments(context);
          });
        },
        child: Card(
          elevation: 10.0,
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Date : $date',
                  style: Theme
                      .of(context)
                      .textTheme
                      .title,
                ),
                Text('Doctor : $doctor'),
                Text('Hospital : $hospital'),
                Text('Diagnosis : $diagnosis'),
                Text('Report_url : ${report_url}'),
                Text('Prescription_url : ${prescription_url}'),
              ],
            ),
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
        .child('UserId1')
        .child('Reports')
        .once()
        .then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      allData.clear();
      for (var key in keys) {
        ReportData d = ReportData(
            data[key]['Date'],
            data[key]['Doctor'],
            data[key]['Hospital'],
            data[key]['Diagnosis'],
            data[key]['ReportUrl'],
            data[key]['PrescriptionUrl']);
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
            'Medical Reports',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.only(top: 4),
          child: allData.length == 0
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
                  itemCount: allData.length,
                  itemBuilder: (_, index) {
                    return UI(
                        allData[index].date,
                        allData[index].doctor,
                        allData[index].hospital,
                        allData[index].diagnosis,
                        allData[index].report_url,
                        allData[index].prescription_url);
                  },
                ),
        ),
      ),
    );
  }
}
