import 'package:flutter/material.dart';

import '../styles/custom_colors.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  const SearchTextField({super.key, required this.controller});

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
        hintText: "Search",
        fillColor: Colors.white,
        suffixIcon: Icon(Icons.search),
      ),
    );
  }
}
