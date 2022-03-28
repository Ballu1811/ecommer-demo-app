import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_app_demo/screens/home_screen.dart';
import 'package:sizer/sizer.dart';

import '../models/category_model.dart';

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
              child: Column(
                children: [
                  Container(
                    height: 12.h,
                    width: 15.w,
                    child: Container(
                      child: const Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                        ),
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("${categories[index].image}")),
                        // boxShadow: [
                        //   BoxShadow(
                        //     blurRadius: 5,
                        //     spreadRadius: 3,
                        //     color: Colors.red.withOpacity(0.4),
                        //   ),
                        // ],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black),
                        // color: Colors
                        //     .primaries[Random().nextInt(categories.length)],
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    categories[index].title!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 10, color: Colors.black),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
