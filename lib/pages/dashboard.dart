import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pix_health/pages/further_appointment_page.dart';
import 'package:pix_health/pages/nearby_hospital_page.dart';
import 'package:pix_health/pages/news_feed_page.dart';
import 'package:pix_health/pages/view_details_page.dart';
import 'package:pix_health/pages/view_medical_history_page.dart';
import 'package:pix_health/pages/view_medicine_page.dart';

import 'loginPage.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key key, this.user});
  final FirebaseUser user;
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  Widget makeCardButton(String text) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        color: Colors.white,
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  Widget makeContainer(BuildContext context, String text, Object obj) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => obj),
        );
      },
      child: makeCardButton(text),
    );
  }

  Widget makeLogoutContainer(BuildContext context, String text, Object obj) {
    return InkWell(
      onTap: () {
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => obj),
            (Route<dynamic> route) => false);
      },
      child: makeCardButton(text),
    );
  }

  Widget title() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(80)),
        gradient: LinearGradient(
          colors: [Colors.yellowAccent, Colors.greenAccent],
          begin: Alignment.centerRight,
          end: new Alignment(1.0, -1.0),
          tileMode: TileMode.mirror,
        ),
      ),
      child: Center(
        child: Text(
          'PixHealth',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w100,
            letterSpacing: 2,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            children: <Widget>[
              title(),
              Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 9,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(36)),
//                    borderRadius: BorderRadius.only(
//                        topLeft: Radius.circular(30),
//                        topRight: Radius.circular(30)),
                    color: Color(0XFFFBB73F),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      makeContainer(context, 'View Details', ViewDetails()),
                      makeContainer(context, 'News Feed', NewsFeed()),
                      makeContainer(
                          context, 'View Medical History', MedicalHistory()),
                      makeContainer(
                          context, 'Further Appointment', FurtherAppointment()),
                      makeContainer(context, 'View Medicines', ViewMedicine()),
                      makeContainer(
                          context, 'Nearby Hospitals', NearbyHospital()),
                      makeLogoutContainer(context, 'Sign Out', LoginPage()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
