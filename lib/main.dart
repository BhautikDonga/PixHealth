import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pix_health/pages/splash_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      title: 'PixHealth',
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
          body1: GoogleFonts.montserrat(
            textStyle: textTheme.body1,
          ),
        ),
      ),
    );
  }
}
