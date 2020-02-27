import 'package:flutter/material.dart';
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

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => SplashPage());
    case '/login':
      return MaterialPageRoute(builder: (context) => LoginPage());
    case '/signup':
      return MaterialPageRoute(builder: (context) => SignUpPage());
    case '/dashboard':
      var email = settings.arguments;
      return MaterialPageRoute(builder: (context) => DashBoard(email: email));
    case '/dashboard/profile':
      var argument = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => ViewDetails(argument: argument));
    case '/dashboard/newsfeed':
      return MaterialPageRoute(builder: (context) => NewsFeed());
    case '/dashboard/medicalhistory':
      var argument = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => MedicalHistory(argument: argument));
    case '/dashboard/medicines':
      var argument = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => ViewMedicine(argument: argument));
    case '/dashboard/furtherappointments':
      var argument = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => FurtherAppointment(argument: argument));
    case '/dashboard/nearbyhospitals':
      return MaterialPageRoute(builder: (context) => NearbyHospital());
    default:
      return MaterialPageRoute(builder: (context) => DashBoard());
  }
}
