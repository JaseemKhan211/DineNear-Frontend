import 'dart:async';

import 'package:dinenear_app/view/screens/Map_Screen.dart';
import 'package:flutter/material.dart';
import 'package:dinenear_app/resources/colors.dart';
import 'package:dinenear_app/resources/images_icons.dart';
import 'package:dinenear_app/view/screens/Select_Radius.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // yaha function hai next page pr jane k lie timer waa
    Timer(Duration(seconds: 8),(){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MapScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/ice-cream.png'),fit: BoxFit.cover)
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          SpinKitFadingCircle(
            duration: Duration(milliseconds: 1200),
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(color: AppColor.primaryColor),
              );
            },
          ),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SelectRadiusScreen(),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 50),
              child: const Center(
                child: Text(
                  'DineNear',
                  style: TextStyle(
                    fontSize: 40,
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ]),
      )

    );
  }
}
