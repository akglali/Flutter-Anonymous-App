import 'package:flutter/material.dart';

class InputModel extends StatelessWidget {
  const InputModel(
      {required this.controller,
      required this.hint,
      required this.validationErr,
      this.keyboardType = TextInputType.text,
      this.color = const Color(0xFFFFEBEE),
      this.isPass=false});

  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final Color color;
  final bool isPass;
  final String validationErr;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value){
          if (value!.length<6){
                return validationErr;
          }
          return null;
        },
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: keyboardType,
        obscureText: isPass,
        style: TextStyle(color: Colors.blueAccent),
        decoration: InputDecoration(
          isDense: true,
          hintText: hint,
          filled: true,
          fillColor: color,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
