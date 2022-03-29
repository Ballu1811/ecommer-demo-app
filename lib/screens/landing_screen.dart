import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app_demo/screens/bottom_navigation.dart';
import 'package:food_app_demo/screens/bottom_screens/home_screen.dart';
import 'package:food_app_demo/screens/auth_screens/login_screen.dart';
import 'package:food_app_demo/utils/style.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);
  Future<FirebaseApp> initilize = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initilize,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, AsyncSnapshot streamSnapshot) {
                if (streamSnapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("${streamSnapshot.error}"),
                    ),
                  );
                }
                if (streamSnapshot.connectionState == ConnectionState.active) {
                  User? user = streamSnapshot.data;
                  if (user == null) {
                    return LoginPage();
                  } else {
                    return BottomNavigationPage();
                  }
                }
                return Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "CHECKING AUTHENTICATION....",
                          textAlign: TextAlign.center,
                          style: EcoStyle.boldStyle,
                        ),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                );
              });
        }
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "INITIALIZATION",
                  textAlign: TextAlign.center,
                  style: EcoStyle.boldStyle,
                ),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }
}
