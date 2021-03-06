import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pix_health/pages/image_listview.dart';
import 'package:pix_health/pages/report_data.dart';
import 'package:pix_health/pages/report_prescription_dialog.dart';

class MedicalHistory extends StatefulWidget {
  final String argument;

  const MedicalHistory({Key key, this.argument}) : super(key: key);

  @override
  _MedicalHistoryState createState() => _MedicalHistoryState();
}

class _MedicalHistoryState extends State<MedicalHistory> {
  List<ReportData> reportData = [];
  List<Widget> _children = [];

  @override
  void initState() {
    //final DashBoard args = ModalRoute.of(context).settings.arguments;
    //final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref
        .child("Users")
        .child(widget.argument)
        .child('Reports')
        .once()
        .then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      reportData.clear();
      for (var key in keys) {
        ReportData d = ReportData(
            data[key]['Date'],
            data[key]['Doctor'],
            data[key]['Hospital'],
            data[key]['Diagnosis'],
            data[key]['ReportUrl'],
            data[key]['PrescriptionUrl']);
        reportData.add(d);
      }
      setState(() {
        print('Length: ${reportData.length}');
      });
    });
  }

  Future<void> _ackDocuments(BuildContext context) {
    return showDialog<void>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: ReportPrescriptionDialogBox(_children),
          );
        });
  }

  Widget UI(String date, String doctor, String hospital, String diagnosis,
      String report_url, String prescription_url) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: () {
          _children.clear();
          _children.add(ImageList(report_url));
          _children.add(ImageList(prescription_url));
          _ackDocuments(context);
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
              ],
            ),
          ),
        ),
      ),
    );
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
          child: reportData.length == 0
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
            itemCount: reportData.length,
                  itemBuilder: (_, index) {
                    return UI(
                        reportData[index].date,
                        reportData[index].doctor,
                        reportData[index].hospital,
                        reportData[index].diagnosis,
                        reportData[index].report_url,
                        reportData[index].prescription_url);
                  },
                ),
        ),
      ),
    );
  }
}
