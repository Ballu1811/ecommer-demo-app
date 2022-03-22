import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_app_demo/screens/home_screen.dart';
import 'package:sizer/sizer.dart';

class CategoryHomeBoxes extends StatelessWidget {
  const CategoryHomeBoxes({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            categories.length,
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 18.h,
                width: 18.w,
                child: Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        categories[index],
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 3,
                        color: Colors.red.withOpacity(0.4),
                      ),
                    ],
                    shape: BoxShape.circle,
                    color:
                        Colors.primaries[Random().nextInt(categories.length)],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
