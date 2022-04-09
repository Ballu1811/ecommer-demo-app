import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app_demo/models/products_model.dart';
import 'package:food_app_demo/utils/style.dart';
import 'package:food_app_demo/widgets/category_home_boxes.dart';
import 'package:sizer/sizer.dart';

// List categories = [
//   "GROCERY",
//   "ELECTRONICS",
//   "COSMETICS",
//   "PHARMACY",
//   "GARMENTS",
//   "LAPTOPS"
// ];

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List images = [
    "https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/01/27/22/10/shopping-1165437_960_720.jpg",
    "https://cdn.pixabay.com/photo/2017/02/12/17/17/music-2060616_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/11/23/15/03/medications-1853400_960_720.jpg",
    "https://cdn.pixabay.com/photo/2012/04/26/22/31/fabric-43354_960_720.jpg",
  ];

  List<Products> allProducts = [];

  getData() async {
    await FirebaseFirestore.instance
        .collection("products")
        .get()
        .then((QuerySnapshot? snapshot) {
      snapshot!.docs.forEach((e) {
        if (e.exists) {
          for (var item in e["imageUrls"]) {
            if (item.isNotEmpty) {
              setState(() {
                allProducts.add(
                  Products(
                    brand: e["brand"],
                    category: e["category"],
                    // id: id,
                    productName: e["productName"],
                    productDetail: e["productDetail"],
                    price: e["price"],
                    discountPrice: e["discountPrice"],
                    serialCode: e["serialCode"],
                    imageUrls: e["imageUrls"],
                    isOnSale: e["isOnSale"],
                    isPopular: e["isPopular"],
                    isFavourite: e["isFavourite"],
                  ),
                );
              });
            }
          }
        }
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                        child: RichText(
                            text: const TextSpan(children: [
                      TextSpan(
                        text: "ECOMMERCE",
                        style: TextStyle(
                          fontSize: 27,
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: "APP",
                        style: TextStyle(
                          fontSize: 27,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]))),
                    const CategoryHomeBoxes(),
                    Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            carousel(images: images),
                            Text(
                              "POPULAR ITEMS",
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            allProducts.length == 0
                                ? CircularProgressIndicator()
                                : PopularIItems(allProducts: allProducts),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Text(
                                            "HOT \n SALES",
                                            textAlign: TextAlign.center,
                                            style: EcoStyle.boldStyle
                                                .copyWith(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Text(
                                            "NEW \n ARRIVAL",
                                            textAlign: TextAlign.center,
                                            style: EcoStyle.boldStyle
                                                .copyWith(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Text(
                                "TOP BRANDS",
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                            ),
                            Brands(allProducts: allProducts),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopularIItems extends StatelessWidget {
  const PopularIItems({
    Key? key,
    required this.allProducts,
  }) : super(key: key);

  final List<Products> allProducts;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: allProducts
            .where((element) => element.isPopular == true)
            .map((e) => Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                e.imageUrls![0],
                                height: 80,
                                width: 80,
                              ),
                            ),
                          ),
                          SizedBox(height: 2),
                          Expanded(
                              child: Container(
                            width: 150,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                e.productName!,
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(overflow: TextOverflow.ellipsis),
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class Brands extends StatelessWidget {
  const Brands({
    Key? key,
    required this.allProducts,
  }) : super(key: key);

  final List<Products> allProducts;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 13.h,
      constraints: BoxConstraints(
        minWidth: 50,
      ),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: allProducts
            .map((e) => Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    child: Container(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                minWidth: 90,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.primaries[Random().nextInt(15)],
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    e.brand![0],
                                    style: EcoStyle.boldStyle.copyWith(
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  e.brand!,
                                  style: EcoStyle.boldStyle.copyWith(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontStyle: FontStyle.normal),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class carousel extends StatelessWidget {
  const carousel({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List images;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
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
                          height: 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 140,
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
                      bottom: 30,
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
          height: 140,
          autoPlay: true,
        ));
  }
}
