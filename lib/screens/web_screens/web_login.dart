import 'package:flutter/material.dart';
import 'package:food_app_demo/screens/web_screens/main_adminpage.dart';
import 'package:food_app_demo/utils/style.dart';
import 'package:food_app_demo/widgets/eco_button.dart';
import 'package:food_app_demo/widgets/ecotextfield.dart';
import 'package:sizer/sizer.dart';

class WebLoginPage extends StatelessWidget {
  // const WebLoginPage({Key? key}) : super(key: key);
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String email = "admin@gmail.com";
  String pass = "admin123";

  submit(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (emailC.text == email && passC.text == pass) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => WebAdminPage()));
      }
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
                    "WELCOME ADMIN PANEL",
                    style: EcoStyle.boldStyle,
                  ),
                  const Text(
                    "Login To Your Admin Account",
                    style: EcoStyle.boldStyle,
                  ),
                  EcoTextField(
                    controller: emailC,
                    hintText: "Enter email...",
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
