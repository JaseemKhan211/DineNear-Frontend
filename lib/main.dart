// ignore_for_file: prefer_const_constructors
import 'package:dinenear_app/data/provider/location_provider.dart';
import 'package:dinenear_app/view/screens/Map_Places_Screen.dart';
import 'package:dinenear_app/view/screens/Splash_Screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LocationProvider()),
    ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoTextTheme()
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
