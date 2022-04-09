import 'package:flutter/material.dart';

class EcoTextField extends StatefulWidget {
  String? hintText;
  TextEditingController? controller;
  String? Function(String?)? validate;
  bool isPassword;
  Widget? icon;
  bool check;
  int? maxLines;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;
  EcoTextField({
    this.hintText,
    this.controller,
    this.validate,
    this.maxLines,
    this.isPassword = false,
    this.icon,
    this.inputAction,
    this.focusNode,
    this.check = false,
  });

  @override
  State<EcoTextField> createState() => _EcoTextFieldState();
}

class _EcoTextFieldState extends State<EcoTextField> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        maxLines: widget.maxLines == 1 ? 1 : widget.maxLines,
        focusNode: widget.focusNode,
        textInputAction: widget.inputAction,
        controller: widget.controller,
        obscureText: widget.isPassword == false ? false : widget.isPassword,
        validator: widget.validate,
        decoration: InputDecoration(
          /// counter: Text("2/5"),
          border: InputBorder.none,
          hintText: widget.hintText ?? 'hint text...',
          suffixIcon: widget.icon,
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
