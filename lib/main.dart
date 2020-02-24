import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pix_health/pages/dashboard.dart';
import 'package:pix_health/pages/further_appointment_page.dart';
import 'package:pix_health/pages/loginPage.dart';
import 'package:pix_health/pages/nearby_hospital_page.dart';
import 'package:pix_health/pages/news_feed_page.dart';
import 'package:pix_health/pages/signup.dart';
import 'package:pix_health/pages/splash_page.dart';
import 'package:pix_health/pages/view_details_page.dart';
import 'package:pix_health/pages/view_medical_history_page.dart';
import 'package:pix_health/pages/view_medicine_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'PixHealth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          body1: GoogleFonts.montserrat(
            textStyle: textTheme.body1,
          ),
        ),
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => SplashPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/dashboard': (context) => DashBoard(),
        '/dashboard/profile': (context) => ViewDetails(),
        '/dashboard/newsfeed': (context) => NewsFeed(),
        '/dashboard/medicalhistory': (context) => MedicalHistory(),
        '/dashboard/medicines': (context) => ViewMedicine(),
        '/dashboard/furtherappointments': (context) => FurtherAppointment(),
        '/dashboard/nearbyhospitals': (context) => NearbyHospital(),
      },
    );
  }
}
