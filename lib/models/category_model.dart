class Category {
  String? title;
  String? image;

  Category({required this.title, this.image});
}

List<Category> categories = [
  Category(title: "GROCERY", image: 'assets/cat_image/grocery.png'),
  Category(title: "ELECTRONICS", image: 'assets/cat_image/gadgets.png'),
  Category(title: "COSMETICS", image: 'assets/cat_image/cosmetics.png'),
  Category(title: "PHARMACY", image: 'assets/cat_image/medicines.png'),
  Category(title: "GARMENTS", image: 'assets/cat_image/garment.png'),
  Category(title: "LAPTOPS", image: 'assets/cat_image/laptop.png'),
];
