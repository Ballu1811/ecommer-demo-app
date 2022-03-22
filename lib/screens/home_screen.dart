import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_app_demo/services/firebase_services.dart';
import 'package:food_app_demo/utils/style.dart';
import 'package:food_app_demo/widgets/category_home_boxes.dart';
import 'package:food_app_demo/widgets/eco_button.dart';
import 'package:sizer/sizer.dart';

import '../widgets/home_cards.dart';

List categories = [
  "GROCERY",
  "ELECTRONICS",
  "COSMETICS",
  "PHARMACY",
  "GARMENTS",
  "LAPTOPS"
];

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List images = [
    "https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/01/27/22/10/shopping-1165437_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/02/12/17/17/music-2060616_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/11/23/15/03/medications-1853400_960_720.jpg",
    "https://cdn.pixabay.com/photo/2012/04/26/22/31/fabric-43354_960_720.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Text("ECOMMERCE APP"),
              ),
              const CategoryHomeBoxes(),
              CarouselSlider(
                  items: images
                      .map((e) => Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    e,
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: LinearGradient(colors: [
                                      Colors.blueAccent.withOpacity(0.3),
                                      Colors.redAccent.withOpacity(0.3),
                                    ]),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 20,
                                child: Container(
                                  color: Colors.black.withOpacity(0.5),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "TITLE",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ))
                      .toList(),
                  options: CarouselOptions(
                    height: 200,
                    autoPlay: true,
                  )),
              Text("POPULAR ITEMS"),
            ],
          ),
        ),
      ),
    );
  }
}
