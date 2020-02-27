import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    String route;
    _auth.currentUser().then((user) {
      if (user == null || (user.isEmailVerified == false)) {
        route = '/login';
      } else {
        route = '/dashboard';
      }
    });
    //while (!isConnected) {}

    Timer(Duration(seconds: 3),
        () => Navigator.of(context).pushReplacementNamed(route));
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
