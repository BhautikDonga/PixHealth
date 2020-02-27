import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pix_health/src/bezierContainer.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _userid, _email, _password;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.reference();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<int> userIds = [];

  @override
  void initState() {
    ref.child('Users').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      for (var key in keys) {
        userIds.add(int.parse(key));
      }
      //print(userIds);
    });
    //print(userIds);
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  showEmailVerificationDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 8,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text(
              "Email verification",
              style: TextStyle(fontFamily: 'CinzelDecorative'),
            ),
            content: Text(
              'An verification email is sent to your registered email address. Please verity it.',
              style: TextStyle(fontFamily: 'McLaren'),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'OK',
                  style: TextStyle(fontSize: 18, fontFamily: 'FontdinerSwanky'),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login', (Route<dynamic> route) => false);
                },
              ),
            ],
          );
        });
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, Widget formFieldWidget) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          formFieldWidget,
        ],
      ),
    );
  }

  Widget emailTextFormField() {
    return TextFormField(
        validator: (String value) {
          value = value.trim();
          bool validEmail = RegExp(r"^[.]+(@gmail.com)$").hasMatch(value);
          if (validEmail) {
            return "Please enter your google email address.";
          } else {
            return null;
          }
        },
        onSaved: (value) {
          setState(() {
            _email = value.toLowerCase().trim();
          });
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Color(0xfff3f3f4),
            filled: true));
  }

  Widget passwordTextFormField() {
    return TextFormField(
        validator: (String value) {
          value = value.trim();
          return value.length < 8 ? "password must have 8 charactes." : null;
        },
        onSaved: (value) {
          setState(() {
            _password = value.trim();
          });
        },
        obscureText: true,
        decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Color(0xfff3f3f4),
            filled: true));
  }

  Widget userIdTextFormField() {
    return TextFormField(
        validator: (String value) {
          value = value.trim();
          bool validUserId = RegExp(r"^[0-9]+$").hasMatch(value);
          if (!validUserId) {
            return "UserId has only numeric value.";
          }
          if (value.length != 12) {
            return "UserId has 12 digits.";
          } else {
            return null;
          }
        },
        onSaved: (value) {
          setState(() {
            _userid = value.trim();
          });
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Color(0xfff3f3f4),
            filled: true));
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("User Id", userIdTextFormField()),
        _entryField("Email Id", emailTextFormField()),
        _entryField("Password", passwordTextFormField()),
      ],
    );
  }

  Widget _offlineSubmitButton() {
    return InkWell(
      onTap: null,
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Connecting..',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(
              width: 5,
            ),
            CupertinoActivityIndicator(radius: 10.0),
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: signUp,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Register Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Already have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'P',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 50,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'ix',
              style: TextStyle(color: Colors.black, fontSize: 50),
            ),
            TextSpan(
              text: 'Health',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 50),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          key: _scaffoldKey,
          body: SingleChildScrollView(
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: SizedBox(),
                          ),
                          _title(),
                          SizedBox(
                            height: 20,
                          ),
                          _emailPasswordWidget(),
                          SizedBox(
                            height: 20,
                          ),
                          ConnectivityWidgetWrapper(
                            stacked: false,
                            offlineWidget: _offlineSubmitButton(),
                            child: _submitButton(),
                          ),
                          Expanded(
                            flex: 4,
                            child: SizedBox(),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: _loginAccountLabel(),
                    ),
                    Positioned(top: 40, left: 0, child: _backButton()),
                    Positioned(
                        top: -MediaQuery
                            .of(context)
                            .size
                            .height * .16,
                        right: -MediaQuery
                            .of(context)
                            .size
                            .width * .45,
                        child: BezierContainer())
                  ],
                ),
              ))),
    );
  }

  Future<void> signUp() async {
    final formState = _formKey.currentState;

    if (formState.validate()) {
      formState.save();
      try {
        showAlertDialog(context);
        print(userIds);
        if (!userIds.contains(int.parse(_userid))) {
          throw FormatException("Your user id is not linked with database");
        }
        await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
        sendEmailVerification();
        String emailPrefix = _email.split("@gmail.com")[0];
        DatabaseReference ref = FirebaseDatabase.instance.reference();
        ref.child("UIds").child("UserID").child(emailPrefix).set(_userid);
        showEmailVerificationDialog(context);
      } catch (e) {
        Navigator.of(context).pop();
        print('Error: ' + e.message);
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(e.message),
          duration: Duration(seconds: 5),
        ));
      }
    }
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _auth.currentUser();
    user.sendEmailVerification();
  }
}
