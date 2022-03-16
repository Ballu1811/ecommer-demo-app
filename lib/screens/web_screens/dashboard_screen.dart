import 'package:flutter/material.dart';
import 'package:food_app_demo/utils/style.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static const String id = "dashboard";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "DASHBOARD",
          style: EcoStyle.boldStyle,
        ),
      ),
    );
  }
}
