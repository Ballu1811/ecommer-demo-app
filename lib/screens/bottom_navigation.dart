import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app_demo/screens/bottom_screens/cart_screen.dart';
import 'package:food_app_demo/screens/bottom_screens/favorite_screen.dart';
import 'package:food_app_demo/screens/bottom_screens/home_screen.dart';
import 'package:food_app_demo/screens/bottom_screens/product_screen.dart';
import 'package:food_app_demo/screens/bottom_screens/profile_screen.dart';

class BottomNavigationPage extends StatelessWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.shop)),
          BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart)),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_rounded)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
        ]),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: HomePage());
              }));
            case 1:
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: ProductScreen());
              }));
            case 2:
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: CartScreen());
              }));
            case 3:
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: FavoriteScreen());
              }));
            case 4:
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: ProfileScreen());
              }));

            default:
          }
          return HomePage();
        });
  }
}
