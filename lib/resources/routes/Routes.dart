import 'package:dinenear_app/resources/routes/Route_Names.dart';
import 'package:dinenear_app/view/screens/Map_Screen.dart';
import 'package:dinenear_app/view/screens/Splash_Screen.dart';
import 'package:flutter/material.dart';

class Routes{
  static MaterialPageRoute generateRoute(RouteSettings settings){
    switch(settings.name){
      case RouteNames.splash:
        return MaterialPageRoute(builder: (BuildContext context) => SplashScreen(),);
      case  RouteNames.Map:
        return MaterialPageRoute(builder: (BuildContext context) => MapScreen());
      default:
        return MaterialPageRoute(builder: (_){
          return Scaffold();
        });
    }
  }
}