import 'package:flutter/material.dart';

class GlobalElevatedButton extends StatelessWidget {

  final VoidCallback onPressed;
  final Color backgroundColor;
  final String buttonText;

  const GlobalElevatedButton({
    required this.onPressed,
    required this.backgroundColor,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        minimumSize: const Size(232, 48),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          fontFamily: "Inter",
        ),
      ),
    );
  }
}
