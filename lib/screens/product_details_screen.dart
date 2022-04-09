import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app_demo/models/products_model.dart';
import 'package:sizer/sizer.dart';

import '../widgets/header.dart';

class ProductDetailScreen extends StatefulWidget {
  final String? id;
  const ProductDetailScreen({Key? key, this.id}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  List<Products> allProducts = [];
  int count = 1;
  var newPrice = 0;

  getData() async {
    await FirebaseFirestore.instance
        .collection("products")
        .get()
        .then((QuerySnapshot? snapshot) {
      snapshot!.docs
          .where((element) => element["id"] == widget.id)
          .forEach((e) {
        if (e.exists) {
          for (var item in e["imageUrls"]) {
            if (item.isNotEmpty) {
              setState(() {
                allProducts.add(
                  Products(
                      id: e["id"],
                      productDetail: e["productDetail"],
                      productName: e["productName"],
                      imageUrls: e["imageUrls"],
                      price: e["price"],
                      discountPrice: e["discountPrice"]),
                );
              });
            }
          }
        }
        newPrice = allProducts.first.price!;
      });
    });
  }

  addToFavrourite() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('favourite');
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .add({
      "pid": allProducts.first.id,
    });

    /// method 1 :- is method se bhi hum current user ka favrourite data firestore me add karwa sakte hai
    /// FirebaseFirestore.instance
    ///     .collection('favourite')
    ///     .doc(FirebaseAuth.instance.currentUser!.uid)
    ///     .collection('items')
    ///     .add({});
  }

  removeToFavrourite(String id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('favourite');
    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .doc(id)
        .delete();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  bool isFav = false;

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return allProducts.isEmpty
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: PreferredSize(
                child: Header(
                  title: "${allProducts.first.productName}",
                ),
                preferredSize: Size.fromHeight(5.h)),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(
                    allProducts[0].imageUrls![selectedIndex],
                    height: 25.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ...List.generate(
                          allProducts[0].imageUrls!.length,
                          (index) => InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 12.h,
                                width: 12.w,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                ),
                                child: Image.network(
                                  allProducts[0].imageUrls![index],
                                  height: 9.h,
                                  width: 9.w,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 7.h,
                      width: 35.w,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "${allProducts.first.price} Rs.",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('favourite')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('items')
                          .where('pid', isEqualTo: allProducts.first.id)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.data == null) {
                          return Text("");
                        }
                        return IconButton(
                          onPressed: () {
                            snapshot.data!.docs.length == 0
                                ? addToFavrourite()
                                : removeToFavrourite(
                                    snapshot.data!.docs.first.id);
                          },
                          icon: Icon(
                            Icons.favorite_border_outlined,
                            color: snapshot.data!.docs.length == 0
                                ? Colors.black
                                : Colors.red,
                          ),
                        );
                      }),
                  Container(
                    constraints: BoxConstraints(
                      minHeight: 30.h,
                      minWidth: double.infinity,
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        allProducts.first.productDetail!,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "NOTE :- Discount of ${allProducts.first.discountPrice} Rs. will be applied when you order more then three items of this products"),
                  ),
                  Container(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (count > 1) {
                                count--;
                                if (count > 3) {
                                  newPrice =
                                      count * allProducts.first.discountPrice!;
                                } else {
                                  newPrice = count * allProducts.first.price!;
                                }
                              }
                            });
                          },
                          icon: Icon(Icons.exposure_minus_1),
                        ),
                        Text(
                          "$count",
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              count++;
                              if (count > 3) {
                                newPrice =
                                    count * allProducts.first.discountPrice!;
                              } else {
                                newPrice = count * allProducts.first.price!;
                              }
                            });
                          },
                          icon: Icon(Icons.exposure_plus_1),
                        ),
                        SizedBox(
                          width: 23,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 7.h,
                            width: 35.w,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Text("${newPrice} Rs.",
                                      style: TextStyle(color: Colors.white))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 7.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                              child: Text("ADD TO CART",
                                  style: TextStyle(color: Colors.white))),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 70),
                ],
              ),
            ),
          );
  }
}
