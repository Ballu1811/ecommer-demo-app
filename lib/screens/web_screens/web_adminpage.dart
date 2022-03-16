import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:food_app_demo/screens/web_screens/addProduct_screen.dart';
import 'package:food_app_demo/screens/web_screens/dashboard_screen.dart';
import 'package:food_app_demo/screens/web_screens/delete_product_screen.dart';
import 'package:food_app_demo/screens/web_screens/update_product_screen.dart';

class WebAdminPage extends StatefulWidget {
  // const WebAdminPage({Key? key}) : super(key: key);
  static const String id = "webmain";

  @override
  State<WebAdminPage> createState() => _WebAdminPageState();
}

class _WebAdminPageState extends State<WebAdminPage> {
  Widget selectedScreen = DashboardScreen();

  chooseScreens(item) {
    switch (item.route) {
      case DashboardScreen.id:
        setState(() {
          selectedScreen = DashboardScreen();
        });
        break;
      case AddProductScreen.id:
        setState(() {
          selectedScreen = AddProductScreen();
        });
        break;
      case UpdateProductScreen.id:
        setState(() {
          selectedScreen = UpdateProductScreen();
        });
        break;
      case DeleteProductScreen.id:
        setState(() {
          selectedScreen = DeleteProductScreen();
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 168, 160, 160),
          title: const Text("ECOMMERCE ADMIN PANEL"),
        ),
        sideBar: SideBar(
          backgroundColor: Colors.black,
          textStyle: const TextStyle(color: Color(0xFfffffff), fontSize: 14),
          onSelected: (item) {
            chooseScreens(item);
          },
          items: const [
            MenuItem(
              title: "DASHBOARD",
              icon: Icons.dashboard,
              route: DashboardScreen.id,
            ),
            MenuItem(
              title: "ADD PRODUCTS",
              icon: Icons.add,
              route: AddProductScreen.id,
            ),
            MenuItem(
              title: "UPDATE PRODUCTS",
              icon: Icons.update,
              route: UpdateProductScreen.id,
            ),
            MenuItem(
              title: "DELETE PRODUCTS",
              icon: Icons.delete,
              route: DeleteProductScreen.id,
            ),
            MenuItem(
              title: "CART ITEMS",
              icon: Icons.shop,
            ),
          ],
          selectedRoute: WebAdminPage.id,
        ),
        body: selectedScreen);
  }
}
