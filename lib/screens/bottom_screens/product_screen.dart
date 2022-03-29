import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/products_model.dart';

class ProductScreen extends StatefulWidget {
  // const ProductScreen({Key? key}) : super(key: key);
  String? category;
  ProductScreen({this.category});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Products> allProducts = [];
  TextEditingController searchC = TextEditingController();

  getData() async {
    await FirebaseFirestore.instance
        .collection("products")
        .get()
        .then((QuerySnapshot? snapshot) {
      snapshot!.docs
          .where((element) => element["category"] == widget.category)
          .forEach((e) {
        if (e.exists) {
          for (var item in e["imageUrls"]) {
            if (item.isNotEmpty) {
              setState(() {
                allProducts.add(
                  Products(
                    // id: id,
                    productName: e["productName"],
                    imageUrls: e["imageUrls"],
                  ),
                );
              });
            }
          }
        }
      });
    });
  }

  List<Products> totalItems = [];

  @override
  void initState() {
    getData();
    Future.delayed(Duration(seconds: 1), () {
      totalItems.addAll(allProducts);
    });

    super.initState();
  }

  filterData(String query) {
    List<Products> dummySearch = [];
    dummySearch.addAll(allProducts);
    if (query.isNotEmpty) {
      List<Products> dummyData = [];
      dummySearch.forEach((element) {
        if (element.productName!.toLowerCase().contains(query.toLowerCase())) {
          dummyData.add(element);
        }
      });
      setState(() {
        allProducts.clear();
        allProducts.addAll(dummyData);
      });
      return;
    } else {
      setState(() {
        allProducts.clear();
        allProducts.addAll(totalItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category! ?? "all products"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: searchC,
              onChanged: (v) {
                filterData(searchC.text);
              },
              decoration: InputDecoration(
                hintText: "Search Your Porduct.....",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: allProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(
                      children: [
                        Image.network(
                          allProducts[index].imageUrls!.last,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        Text(allProducts[index].productName!),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
