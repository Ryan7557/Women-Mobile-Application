import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextfield extends StatefulWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  final String? Function(String?)? validator;

  const MyTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.validator,
  });

  @override
  State<MyTextfield> createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade500),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          fillColor: Colors.white54,
          filled: true,
          hintText: widget.hintText,
          hintStyle: GoogleFonts.oswald(
            color: Colors.grey[500],
          ),
          errorText: widget.validator?.call(widget.controller.text),
        ),
        validator: (value) => validateUsername(value),
      ),
    );
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username cannot be empty.';
    }

    final usernameRegEx =
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$');
    if (!usernameRegEx.hasMatch(value)) {
      return 'Username must contain letters, numbers, and symbols.';
    }
    return null;
  }
}
