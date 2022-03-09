import 'package:flutter/material.dart';
import 'package:food_app_demo/screens/landing_screen.dart';
import 'package:food_app_demo/screens/web_screens/web_login.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.minWidth > 600) {
          return WebLoginPage();
        } else {
          return LandingPage();
        }
      },
    );
  }
}
