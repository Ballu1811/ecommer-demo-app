import 'package:flutter/material.dart';
import 'package:food_app_demo/screens/bottom_screens/home_screen.dart';
import 'package:food_app_demo/screens/auth_screens/signup_screen.dart';
import 'package:food_app_demo/utils/style.dart';
import 'package:food_app_demo/widgets/eco_button.dart';
import 'package:food_app_demo/widgets/ecotextfield.dart';

import '../../services/firebase_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  Future<void> ecoDialogue(String error) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(error),
            actions: [
              EcoButton(
                title: 'CLOSE',
                onPress: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  submit() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        formStateLoading = true;
      });

      String? accountstatus = await FirebaseServices.signInAccount(
          emailController.text, passController.text);
      if (accountstatus != null) {
        ecoDialogue(accountstatus);
        setState(() {
          formStateLoading = false;
        });
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
      }
    }
  }

  final formKey = GlobalKey<FormState>();
  bool formStateLoading = false;
  bool isPass = true;
  bool isConfirmPass = true;

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
                      key: formKey,
                      child: Column(
                        children: [
                          EcoTextField(
                            controller: emailController,
                            hintText: "Enter email...",
                            validate: (v) {
                              if (v!.isEmpty ||
                                  !v.contains("@") ||
                                  !v.contains(".com")) {
                                return "email is badly formated";
                              }
                              return null;
                            },
                          ),
                          EcoTextField(
                            controller: passController,
                            hintText: "Enter Password...",
                            validate: (v) {
                              if (v!.isEmpty) {
                                return "password should not be empty";
                              }
                              return null;
                            },
                          ),
                          EcoButton(
                            title: "LOGIN",
                            isLoading: formStateLoading,
                            isLoginButton: true,
                            onPress: () {
                              submit();
                            },
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
