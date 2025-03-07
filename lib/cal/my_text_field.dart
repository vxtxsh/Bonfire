import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final int line;
  final Function()? onTap;
  final Color labelColor;
  final Color fillColor;
  final Color textColor;

  const CustomTextInput({
    Key? key,
    required this.controller,
    required this.label,
    this.line = 1,
    this.onTap,
    this.labelColor = Colors.black, // Default to black
    this.fillColor = Colors.grey, // Default to white
    this.textColor = Colors.black, // Default to black
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: line,
      onTap: onTap,
      style: TextStyle(color: textColor), // Set input text color
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: labelColor), // Set label text color
        filled: true,
        fillColor: fillColor, // Set background color for the field
        border: const OutlineInputBorder(), // Outlined border
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: labelColor), // Border color when focused
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color:
                  fillColor.withOpacity(0.5)), // Border color when not focused
        ),
      ),
    );
  }
}
