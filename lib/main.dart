import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app_demo/screens/landing_screen.dart';
import 'package:food_app_demo/screens/layout_screen.dart';
import 'package:food_app_demo/screens/login_screen.dart';
import 'package:food_app_demo/screens/web_screens/addProduct_screen.dart';
import 'package:food_app_demo/screens/web_screens/dashboard_screen.dart';
import 'package:food_app_demo/screens/web_screens/delete_product_screen.dart';
import 'package:food_app_demo/screens/web_screens/update_complete_screen.dart';
import 'package:food_app_demo/screens/web_screens/update_product_screen.dart';
import 'package:food_app_demo/screens/web_screens/web_adminpage.dart';
import 'package:food_app_demo/screens/web_screens/web_login.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyD9iI40s8kvtlBZ3-o5brCYjXq_Me8kMT4",
            authDomain: "ecommerce-demo-app-d8b61.firebaseapp.com",
            projectId: "ecommerce-demo-app-d8b61",
            storageBucket: "ecommerce-demo-app-d8b61.appspot.com",
            messagingSenderId: "175192772332",
            appId: "1:175192772332:web:cb13879f15b8c6b5dd5fc9"));
  } else {
    await Firebase.initializeApp();
  }
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        title: 'Ecommerce Demo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.white,
        ),
        home: LayoutScreen(),
        routes: {
          WebLoginPage.id: (context) => WebLoginPage(),
          WebAdminPage.id: (context) => WebAdminPage(),
          AddProductScreen.id: (context) => AddProductScreen(),
          UpdateProductScreen.id: (context) => UpdateProductScreen(),
          DeleteProductScreen.id: (context) => DeleteProductScreen(),
          DashboardScreen.id: (context) => DashboardScreen(),
          UpdateCompleteScreen.id: (context) => UpdateCompleteScreen(),
        },
      ),
    );
  }
}
