import 'package:flutter/material.dart';

class EcoTextField extends StatefulWidget {
  String? hintText;
  TextEditingController? controller;
  String? Function(String?)? validate;
  bool isPassword;
  IconData? icon;
  bool check;
  EcoTextField({
    this.hintText,
    this.controller,
    this.validate,
    this.isPassword = false,
    this.icon,
    this.check = false,
  });

  @override
  State<EcoTextField> createState() => _EcoTextFieldState();
}

class _EcoTextFieldState extends State<EcoTextField> {
  List<bool> isP = [false, false, false];

  Icon iconChecker() {
    if (widget.isPassword == true) {
      return const Icon(Icons.visibility);
    } else if (widget.isPassword == false &&
        widget.hintText == "Enter email...") {
      return const Icon(Icons.email);
    } else if (widget.isPassword == false) {
      return const Icon(Icons.visibility_off);
    }
    return const Icon(Icons.abc);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword == false ? false : widget.isPassword,
        validator: widget.validate,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText ?? 'hint text...',
          suffixIcon: IconButton(
            onPressed: () {
              if (widget.isPassword == false) {
                setState(() {
                  widget.isPassword = true;
                });
              } else {
                setState(() {
                  widget.isPassword = false;
                });
              }
            },
            icon: iconChecker(),
          ),
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
