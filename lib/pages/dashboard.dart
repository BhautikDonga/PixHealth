import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key key, this.user});
  final FirebaseUser user;
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 8,
            //backgroundColor: Color(0xFFffd589),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text(
              'Are you sure?',
              style: TextStyle(fontFamily: 'CinzelDecorative'),
            ),
            content: Text(
              'You are going to exit the application!!',
              style: TextStyle(fontFamily: 'McLaren'),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'NO',
                  style: TextStyle(fontSize: 18, fontFamily: 'FontdinerSwanky'),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text(
                  'YES',
                  style: TextStyle(fontSize: 18, fontFamily: 'FontdinerSwanky'),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        });
  }

  Future<void> _onSignOutPressed() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 8,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text('Are you sure?'),
            content: Text('You are going to Log out from application!!'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login', (Route<dynamic> route) => false);
                },
              ),
            ],
          );
        });
  }

  Widget makeCardButton(String text) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        color: Colors.white,
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'CroissantOne',
              fontSize: 22,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  Widget makeContainer(BuildContext context, String text, String route) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: makeCardButton(text),
    );
  }

  Widget makeLogoutContainer(BuildContext context, String text) {
    return InkWell(
      onTap: () {
        _onSignOutPressed();
      },
      child: makeCardButton(text),
    );
  }

  Widget title() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        gradient: LinearGradient(
          //colors: [Colors.yellowAccent, Colors.greenAccent],
          colors: [Color(0xFFFFCF00), Color(0xFFFFDF01)],
          begin: Alignment.center,
          end: new Alignment(1.0, 8.0),
          tileMode: TileMode.repeated,
        ),
      ),
      child: Center(
        child: Text(
          'PixHealth',
          style: TextStyle(
            fontFamily: 'VastShadow',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
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
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(36)),
                        color: Color(0xFFFFBA03)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        makeContainer(
                            context, 'View Details', '/dashboard/profile'),
                        makeContainer(
                            context, 'News Feed', '/dashboard/newsfeed'),
                        makeContainer(context, 'View Medical History',
                            '/dashboard/medicalhistory'),
                        makeContainer(context, 'Further Appointment',
                            '/dashboard/furtherappointments'),
                        makeContainer(
                            context, 'View Medicines', '/dashboard/medicines'),
                        makeContainer(context, 'Nearby Hospitals',
                            '/dashboard/nearbyhospitals'),
                        makeLogoutContainer(context, 'Sign Out'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
