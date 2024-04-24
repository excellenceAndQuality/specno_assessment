import 'package:flutter/material.dart';

import '../styles/custom_colors.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const TextFieldWidget({super.key, required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(
          fontSize: 16,
          fontFamily: "Inter",
          color: CustomColors.hint
      ),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide:  const BorderSide(color: CustomColors.textFieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide:  const BorderSide(color: CustomColors.textFieldBorder),
        ),
        filled: true,
        hintStyle: const TextStyle(
            fontSize: 16,
            fontFamily: "Inter",
            color: CustomColors.hint),
        hintText: hint,
        fillColor: Colors.white,
      ),
    );
  }
}
