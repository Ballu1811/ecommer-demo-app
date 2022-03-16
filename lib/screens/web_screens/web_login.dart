import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app_demo/screens/web_screens/web_adminpage.dart';
import 'package:food_app_demo/services/firebase_services.dart';
import 'package:food_app_demo/utils/style.dart';
import 'package:food_app_demo/widgets/eco_button.dart';
import 'package:food_app_demo/widgets/eco_dialog.dart';
import 'package:food_app_demo/widgets/ecotextfield.dart';
import 'package:sizer/sizer.dart';

class WebLoginPage extends StatefulWidget {
  static const String id = "weblogin";
  @override
  State<WebLoginPage> createState() => _WebLoginPageState();
}

class _WebLoginPageState extends State<WebLoginPage> {
  // const WebLoginPage({Key? key}) : super(key: key);
  TextEditingController userNameC = TextEditingController();

  TextEditingController passC = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool formStateLoading = false;

  submit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      setState(() {
        formStateLoading = true;
      });
      await FirebaseServices.adminSignIn(userNameC.text).then((value) async {
        if (value['username'] == userNameC.text &&
            value['password'] == passC.text) {
          try {
            UserCredential user =
                await FirebaseAuth.instance.signInAnonymously();
            if (user != null) {
              Navigator.pushReplacementNamed(context, WebAdminPage.id);
            }
          } catch (e) {
            setState(() {
              formStateLoading = false;
            });
            showDialog(
                context: context,
                builder: (_) {
                  return EcoDialogue(
                    title: e.toString(),
                  );
                });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "WELCOME ADMIN PAGE",
                    style: EcoStyle.boldStyle,
                  ),
                  const Text(
                    "Login With Admin Account",
                    style: EcoStyle.boldStyle,
                  ),
                  EcoTextField(
                    controller: userNameC,
                    hintText: "User Name...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "email should not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoTextField(
                    controller: passC,
                    isPassword: true,
                    hintText: "Enter Password...",
                    validate: (v) {
                      if (v!.isEmpty) {
                        return "Password should not be empty";
                      }
                      return null;
                    },
                  ),
                  EcoButton(
                    isLoginButton: true,
                    isLoading: formStateLoading,
                    onPress: () {
                      submit(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
