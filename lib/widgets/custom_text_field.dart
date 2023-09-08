import 'package:flutter/material.dart';
import 'package:tictactoe/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController namecontroller;
  final String hintText;
  final isReadOnly;

  const CustomTextField(
      {Key? key, // Use 'key' instead of 'super.key'
      required this.namecontroller,
      required this.hintText,
      this.isReadOnly = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.blue,
          blurRadius: 5,
          spreadRadius: 2,
        ),
      ]),
      child: TextField(
        readOnly: isReadOnly,
        controller: namecontroller,
        decoration: InputDecoration(
          fillColor: bgColor, // Ensure 'bgColor' is defined correctly
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}
