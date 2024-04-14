import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  String? Function(String?)? validator;
  final bool obscureText;
  MyTextfield({
    super.key,
    this.validator,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        validator: validator,
      ),
    );
  }
}
