import 'package:flutter/material.dart';

class MyTextFieldFocus extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final FocusNode myFocusNode;

  const MyTextFieldFocus({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.myFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        focusNode: myFocusNode,
        validator: (value) {
          if (value!.isEmpty) {
            return "";
          }
          return null;
        },
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.white.withOpacity(0.8),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
    );
  }
}
