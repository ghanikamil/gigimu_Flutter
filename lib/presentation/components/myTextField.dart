import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hinText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hinText,
    required this.obscureText
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field tidak boleh kosong';
          }
          return null;
        },
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(8)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400)
            ),
            filled: true,
            hintText: hinText,
            hintStyle: TextStyle(color: Colors.grey.shade500)
        ),
      ),
    );
  }
}
