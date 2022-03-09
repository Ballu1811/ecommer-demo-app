import 'package:flutter/material.dart';
import 'package:food_app_demo/screens/login_screen.dart';
import 'package:food_app_demo/services/firebase_services.dart';
import 'package:food_app_demo/utils/style.dart';
import 'package:food_app_demo/widgets/eco_button.dart';
import 'package:food_app_demo/widgets/ecotextfield.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // const SignUpPage({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  TextEditingController confirmPassController = TextEditingController();
  FocusNode? passFocus;
  FocusNode? confirmPassFocus;
  final formKey = GlobalKey<FormState>();

  bool isPass = true;
  bool isConfirmPass = true;
  bool formStateLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

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
      if (passController.text == confirmPassController.text) {
        setState(() {
          formStateLoading = true;
        });
        String? accountstatus = await FirebaseServices.createAccount(
            emailController.text, passController.text);
        if (accountstatus != null) {
          ecoDialogue(accountstatus);
          setState(() {
            formStateLoading = false;
          });
        } else {
          Navigator.pop(context);
        }

        //  Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));

      }
    }
  }

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
                      SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              EcoTextField(
                                check: true,
                                validate: (v) {
                                  if (v!.isEmpty ||
                                      !v.contains("@") ||
                                      !v.contains(".com")) {
                                    return "email is badly formated";
                                  }
                                  return null;
                                },
                                inputAction: TextInputAction.next,
                                isPassword: false,
                                controller: emailController,
                                hintText: "Enter email...",
                                icon: const Icon(Icons.email),
                              ),
                              EcoTextField(
                                validate: (v) {
                                  if (v!.isEmpty) {
                                    return "password should not be empty";
                                  }
                                  return null;
                                },
                                inputAction: TextInputAction.next,
                                isPassword: isPass,
                                controller: passController,
                                hintText: "Enter Password...",
                                icon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isPass = !isPass;
                                    });
                                  },
                                  icon: isPass
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                ),
                              ),
                              EcoTextField(
                                validate: (v) {
                                  if (v!.isEmpty) {
                                    return "Confirm password should not be empty";
                                  }
                                  return null;
                                },
                                isPassword: isConfirmPass,
                                controller: confirmPassController,
                                hintText: "Confirm Password...",
                                icon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isConfirmPass = !isConfirmPass;
                                    });
                                  },
                                  icon: isConfirmPass
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                ),
                              ),
                              EcoButton(
                                title: "SIGNUP",
                                isLoginButton: true,
                                onPress: () {
                                  submit();
                                },
                                isLoading: formStateLoading,
                              ),
                            ],
                          ),
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
