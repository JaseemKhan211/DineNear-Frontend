import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';


class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => NavBarState();
}

// This is the list of screen items
final List<Widget> _screens = [
  const Center(child: Text('Home')),
  const Center(child: Text('Menu')),
  const Center(child: Text('Add')),
  const Center(child: Text('Notifications')),
  const Center(child: Text('Location')),
];

class NavBarState extends State<NavBar> {
  int selectedIndex = 0; // Initialize selectedIndex to 0

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      child: CurvedNavigationBar(
        animationDuration: const Duration(milliseconds: 200),
        backgroundColor: AppColor.transparentColor,
        buttonBackgroundColor: AppColor.transparentColor,
        color: AppColor.btnColor,
        items: [
          Icon(
            Icons.home_outlined,
            size: 30,
            color: selectedIndex == 0
                ? AppColor.btnColor
                : AppColor.whiteColor,
          ),
          Icon(
            CupertinoIcons.line_horizontal_3,
            size: 30,
            color: selectedIndex == 1
                ? AppColor.btnColor
                : AppColor.whiteColor,
          ),
          Icon(
            Icons.add_outlined,
            size: 30,
            color: selectedIndex == 2
                ? AppColor.btnColor
                : AppColor.whiteColor,
          ),
          Icon(
            Icons.notifications_outlined,
            size: 30,
            color: selectedIndex == 3
                ? AppColor.btnColor
                : AppColor.whiteColor,
          ),
          Icon(
            Icons.location_on_outlined,
            size: 30,
            color: selectedIndex == 4
                ? AppColor.btnColor
                : AppColor.whiteColor,
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
