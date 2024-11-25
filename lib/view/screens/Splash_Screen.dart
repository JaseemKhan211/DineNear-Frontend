import 'package:flutter/material.dart';
import 'package:dinenear_app/resources/colors.dart';
import 'package:dinenear_app/resources/images_icons.dart';
import 'package:dinenear_app/view/screens/Select_Radius.dart';

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
    Future.delayed(const Duration(seconds: 22), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const SelectRadiusScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              Assets.splashimg,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),

            // yahan pr title or progress bar show hoga just
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CircularProgressIndicator(color: AppColor.primaryColor),
              SizedBox(height: MediaQuery.sizeOf(context).height*0.01),
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
                    margin: const EdgeInsets.symmetric( vertical: 50),
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
          ],
        ),
      ),
    );
  }
}
