import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app_demo/screens/product_details_screen.dart';
import 'package:food_app_demo/widgets/header.dart';
import 'package:sizer/sizer.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List ids = [];
  getId() async {
    FirebaseFirestore.instance
        .collection('favourite')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('items')
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
      snapshot.docs.forEach((element) {
        setState(() {
          ids.add(element['pid']);
        });
      });
    });
  }

  @override
  void initState() {
    getId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.h),
          child: Header(
            title: "FAVOURITE",
          )),
      body: Center(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            if (snapshot.data == null) {
              return Center(child: Text("No Favourite Items Found"));
            }
            List<QueryDocumentSnapshot<Object?>> fvp = snapshot.data!.docs
                .where((element) => ids.contains(element["id"]))
                .toList();
            return ListView.builder(
                itemCount: fvp.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.7.h, horizontal: 5.w),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ProductDetailScreen(
                                      id: fvp[index]['id'],
                                    )));
                      },
                      child: Card(
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Colors.primaries[Random().nextInt(4)],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: Text(
                                fvp[index]['productName'],
                                style:
                                    TextStyle(overflow: TextOverflow.ellipsis),
                              ),
                              trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.navigate_next_outlined)),
                            ),
                          )),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
