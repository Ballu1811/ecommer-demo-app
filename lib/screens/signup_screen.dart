import 'package:flutter/material.dart';
import 'package:food_app_demo/screens/login_screen.dart';
import 'package:food_app_demo/utils/style.dart';
import 'package:food_app_demo/widgets/eco_button.dart';
import 'package:food_app_demo/widgets/ecotextfield.dart';

class SignUpPage extends StatelessWidget {
  // const SignUpPage({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController validatePassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Welcome Ecommerce App \n Create New Account",
                    textAlign: TextAlign.center,
                    style: EcoStyle.boldStyle,
                  ),
                  Column(
                    children: [
                      Form(
                        child: Column(
                          children: [
                            EcoTextField(
                              controller: emailController,
                              hintText: "Enter email...",
                            ),
                            EcoTextField(
                              isPassword: true,
                              controller: passController,
                              hintText: "Enter Password...",
                            ),
                            EcoTextField(
                              isPassword: true,
                              controller: validatePassController,
                              hintText: "Confirm Password...",
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
                  const SizedBox(height: 50),
                  EcoButton(
                    title: "Allready have an Account? Login Here....",
                    onPress: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => LoginPage()));
                    },
                    isLoginButton: false,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
