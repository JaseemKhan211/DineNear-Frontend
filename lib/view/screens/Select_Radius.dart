// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dinenear_app/resources/customwidgets/Nav_Bar.dart';
import 'package:flutter/material.dart';

import '../../resources/colors.dart';

class SelectRadiusScreen extends StatefulWidget {
  const SelectRadiusScreen({super.key});

  @override
  State<SelectRadiusScreen> createState() => _SelectRadiusScreenState();
}

class _SelectRadiusScreenState extends State<SelectRadiusScreen> {
  int index = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          centerTitle: true,
          title: Text(
            'Select Radius',
            style: TextStyle(color: AppColor.textWhiteColor),
          ),
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ye center wala container banega jiske andr apki screen ka center wala hissa ayga
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 1,
                    decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Select Your Area',
                            style: TextStyle(color: AppColor.whiteColor)),
                        // Container(
                        //   decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(10)),
                        //   // Yahan wo dropdown wala pura widget call hoga
                        //   child: SelectRadiusDropdown(),
                        // ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            alignment: Alignment.center,
                            iconColor: AppColor.whiteColor,
                          ),
                          child: Text('Submit',
                              style: TextStyle(color: AppColor.primaryColor)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // yahan par nav bar filhal mene index dedea , functionalities will be added later
        bottomNavigationBar: NavBar());
  }
}
