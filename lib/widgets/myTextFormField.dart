import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final int maxLines;
  bool isPassword;
  TextInputType? keyboardType;
  String? Function(String?)? validator;
  Widget? suffixIcon;
MyTextFormField({required this.controller,
  required this.labelText,
  this.maxLines=1,
  this.isPassword=false,
  this.validator,
  this.keyboardType,
  this.suffixIcon
});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: isPassword,
        keyboardType: keyboardType,
        validator: validator,
        controller: controller,
        decoration:  InputDecoration(
          suffixIcon: suffixIcon,
          label: Text(
            labelText,
          ),
          labelStyle:Theme.of(context).textTheme.bodyMedium,
        ),
        style: Theme.of(context).textTheme.bodyMedium,
        maxLines: maxLines,
      ),
    );
  }
}
