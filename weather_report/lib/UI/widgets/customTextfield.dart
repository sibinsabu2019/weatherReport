import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextStyle hintStyle;
  final bool obscureText;
  final FormFieldValidator<String> validator;
  final TextEditingController controller;

  const CustomTextFormField({super.key, 
    required this.hintText,
    required this.hintStyle,
    this.obscureText = false,
    required this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }
}