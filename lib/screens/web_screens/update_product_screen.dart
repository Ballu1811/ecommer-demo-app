import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app_demo/models/products_model.dart';
import 'package:food_app_demo/screens/web_screens/update_dialogue_product.dart';
// import 'package:food_app_demo/screens/web_screens/update_complete_screen.dart';
import 'package:food_app_demo/utils/style.dart';

class UpdateProductScreen extends StatelessWidget {
  const UpdateProductScreen({Key? key}) : super(key: key);
  static const String id = "updateproduct";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            const Text(
              "UPDATE PRODUCT",
              style: EcoStyle.boldStyle,
            ),
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('products').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data == null) {
                  return const Center(child: Text("No Data Exists"));
                }
                final data = snapshot.data!.docs;

                return Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                            color: Colors.black,

                            /// Colors.primaries[Random().nextInt(data.length)],
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: GestureDetector(
                                onTap: () {},
                                child: ListTile(
                                  title: Text(
                                    data[index]['productName'],
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  trailing: Container(
                                    width: 200,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Products.deleteProduct(
                                                data[index].id);
                                          },
                                          icon:
                                              const Icon(Icons.delete_forever),
                                          color: Colors.white,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (_) {
                                              return UpdateCompleteScreen(
                                                id: data[index].id,
                                                products: Products(
                                                  brand: data[index]["brand"],
                                                  category: data[index]
                                                      ["category"],
                                                  id: id,
                                                  productName: data[index]
                                                      ["productName"],
                                                  productDetail: data[index]
                                                      ["productDetail"],
                                                  price: data[index]["price"],
                                                  discountPrice: data[index]
                                                      ["discountPrice"],
                                                  serialCode: data[index]
                                                      ["serialCode"],
                                                  imageUrls: data[index]
                                                      ["imageUrls"],
                                                  isOnSale: data[index]
                                                      ["isOnSale"],
                                                  isPopular: data[index]
                                                      ["isPopular"],
                                                  isFavourite: data[index]
                                                      ["isFavourite"],
                                                ),
                                              );
                                            }));
                                            // Navigator.pushReplacementNamed(
                                            //     context, UpdateCompleteScreen.id);
                                          },
                                          icon: const Icon(Icons.edit),
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
