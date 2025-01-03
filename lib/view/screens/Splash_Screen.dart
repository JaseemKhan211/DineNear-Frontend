import 'dart:async';

import 'package:dinenear_app/view/screens/Map_Screen.dart';
import 'package:flutter/material.dart';
import '../../resources/text styles/App_TextStyles.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  // yaha function hai next page pr jane k lie timer waa
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MapScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(266, 255, 0, 0),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/splash_dinenear.jpg'),fit: BoxFit.cover)
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 50),
                      child: Center(
                        child: Text(
                          'DineNear', style: AppTextStyles.SplashStyle,
                        ),
                      ),
                    ),
                  ]),
            ),
          ],
        ),

      )

    );
  }
}
