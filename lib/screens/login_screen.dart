import 'package:flutter/material.dart';
import 'package:food_app_demo/screens/signup_screen.dart';
import 'package:food_app_demo/utils/style.dart';
import 'package:food_app_demo/widgets/eco_button.dart';
import 'package:food_app_demo/widgets/ecotextfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Welcome Ecommerce App \n Please Login First",
                  textAlign: TextAlign.center,
                  style: EcoStyle.boldStyle,
                ),
                Column(
                  children: [
                    Form(
                      child: Column(
                        children: [
                          EcoTextField(
                            hintText: "Enter email...",
                          ),
                          EcoTextField(
                            isPassword: true,
                            hintText: "Enter Password...",
                          ),
                          EcoButton(
                            title: "LOGIN",
                            isLoginButton: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                EcoButton(
                  title: "Create a new Account",
                  onPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SignUpPage()));
                  },
                  isLoginButton: false,
                ),
              ]),
        ),
      ),
    );
  }
}
