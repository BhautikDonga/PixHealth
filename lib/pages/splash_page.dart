import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pix_health/pages/dashboard.dart';
import 'package:pix_health/pages/loginPage.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    Object obj;
    _auth.currentUser().then((user) {
      if (user == null) {
        obj = LoginPage();
      } else {
        obj = DashBoard(user: user);
      }
    });
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => obj)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.orangeAccent,
          child: Center(
            child: Text(
              'PixHealth',
              style: TextStyle(
                fontFamily: 'TradeWinds',
                fontSize: 50,
              ),
            ),
          ),
        ));
  }
}
