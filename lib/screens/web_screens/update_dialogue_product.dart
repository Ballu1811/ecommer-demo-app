import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_app_demo/models/products_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

import '../../models/category_model.dart';
import '../../utils/style.dart';
import '../../widgets/eco_button.dart';
import '../../widgets/ecotextfield.dart';
import '../home_screen.dart';

class UpdateCompleteScreen extends StatefulWidget {
  String? id;
  Products? products;
  UpdateCompleteScreen({Key? key, this.id, this.products}) : super(key: key);

  @override
  State<UpdateCompleteScreen> createState() => _UpdateCompleteScreenState();
}

class _UpdateCompleteScreenState extends State<UpdateCompleteScreen> {
  TextEditingController categoryC = TextEditingController();
  TextEditingController idC = TextEditingController();
  TextEditingController productNameC = TextEditingController();
  TextEditingController productDetailC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController discountPriceC = TextEditingController();
  TextEditingController serialCodeC = TextEditingController();
  TextEditingController brandC = TextEditingController();

  bool isOnSale = false;
  bool isPopular = false;
  bool isFavourite = false;

  String? selectedValue = "";
  bool isSaving = false;
  bool isUploading = false;
  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<dynamic> imageUrls = [];
  var uuid = Uuid();

  @override
  void initState() {
    selectedValue = widget.products!.category!;
    productNameC.text = widget.products!.productName!;
    productDetailC.text = widget.products!.productDetail!;
    priceC.text = widget.products!.price!.toString();
    discountPriceC.text = widget.products!.discountPrice!.toString();
    serialCodeC.text = widget.products!.serialCode!;
    isOnSale = widget.products!.isOnSale!;
    isPopular = widget.products!.isPopular!;
    isFavourite = widget.products!.isFavourite!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Column(
                children: [
                  const Text(
                    "UPDATE PRODUCT",
                    style: EcoStyle.boldStyle,
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonFormField(
                      hint: const Text("Choose Your Category"),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return "category must be selected";
                        }
                        return null;
                      },
                      value: selectedValue,
                      items: categories
                          .map((e) => DropdownMenuItem<String>(
                              value: e.title, child: Text(e.title!)))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value.toString();
                        });
                      },
                    ),
                  ),
                  EcoTextField(
                    controller: productNameC,
                    hintText: "Enter Product Name...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    maxLines: 5,
                    controller: productDetailC,
                    hintText: "Enter Product Details...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    controller: priceC,
                    hintText: "Enter Product Price...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    controller: discountPriceC,
                    hintText: "Enter Product Discount Price...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    controller: serialCodeC,
                    hintText: "Enter Product Serial Code...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    controller: brandC,
                    hintText: "Enter Product Brand...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "should not be empty";
                      }
                      return null;
                    },
                  ),
                  Container(
                    height: 25.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                      ),
                      itemCount: widget.products!.imageUrls!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: Image.network(
                                  widget.products!.imageUrls![index],
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.products!.imageUrls!
                                          .removeAt(index);
                                    });
                                  },
                                  icon: const Icon(Icons.cancel_outlined)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  EcoButton(
                    title: "PICK IMAGES",
                    onPress: () {
                      pickImage();
                    },
                    isLoginButton: true,
                  ),

                  /// EcoButton(
                  ///   title: "UPLOAD IMAGES",
                  ///   isLoading: isUploading,
                  ///   onPress: () {
                  ///     uploadImages();
                  ///   },
                  ///   isLoginButton: true,
                  /// ),
                  Container(
                    height: 45.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                      ),
                      itemCount: images.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: Image.network(
                                  File(images[index].path).path,
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      images.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(Icons.cancel_outlined)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  SwitchListTile(
                      title: Text("Is this Product on Sale?"),
                      value: isOnSale,
                      onChanged: (v) {
                        setState(() {
                          isOnSale = !isOnSale;
                        });
                      }),
                  SwitchListTile(
                      title: Text("Is this Product Popular?"),
                      value: isPopular,
                      onChanged: (v) {
                        setState(() {
                          isPopular = !isPopular;
                        });
                      }),
                  EcoButton(
                    title: "SAVE",
                    isLoginButton: true,
                    onPress: () {
                      save();
                    },
                    isLoading: isSaving,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  save() async {
    setState(() {
      isSaving = true;
    });
    await uploadImages();
    await Products.updateProducts(
        widget.id!,
        Products(
          brand: brandC.text,
          category: selectedValue,
          id: widget.id!,
          productName: productNameC.text,
          productDetail: productDetailC.text,
          price: int.parse(priceC.text),
          discountPrice: int.parse(discountPriceC.text),
          serialCode: serialCodeC.text,
          imageUrls: imageUrls,
          isOnSale: isOnSale,
          isPopular: isPopular,
          isFavourite: isFavourite,
        )).whenComplete(() {
      setState(() {
        isSaving = false;
        images.clear();
        imageUrls.clear();
        clearField();
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("ADDED SUCCESSFULLY")));
      });
    });

    /// await FirebaseFirestore.instance
    ///     .collection("products")
    ///     .add({"images": imageUrls}).whenComplete(() {
    ///  setState(() {
    ///     isSaving = false;
    ///     images.clear();
    ///     imageUrls.clear();
    ///   });
    /// });
  }

  clearField() {
    setState(() {
      //  selectedValue = "";
      productNameC.clear();
      productDetailC.clear();
      priceC.clear();
      discountPriceC.clear();
      serialCodeC.clear();
      isOnSale = false;
      isPopular = false;
    });
  }

  pickImage() async {
    final List<XFile>? pickImage = await imagePicker.pickMultiImage();
    if (pickImage != null) {
      setState(() {
        images.addAll(pickImage);
      });
    } else {
      print("No images selected");
    }
  }

  Future postImages(XFile? imageFile) async {
    setState(() {
      isUploading = true;
    });
    String? urls;
    Reference ref =
        FirebaseStorage.instance.ref().child("images").child(imageFile!.name);
    if (kIsWeb) {
      await ref.putData(
        await imageFile.readAsBytes(),
        SettableMetadata(contentType: "image/jped"),
      );
      urls = await ref.getDownloadURL();
      setState(() {
        isUploading = false;
      });
      return urls;
    }
  }

  uploadImages() async {
    for (var image in images) {
      await postImages(image).then((downloadUrl) => imageUrls.add(downloadUrl));
    }
    imageUrls.addAll(widget.products!.imageUrls!);
  }
}
