import 'package:flutter/material.dart';

extension ShowSnackBar on BuildContext {
  void showSnackbar(
      {required String message, Color backgroundColor = Colors.amber}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
      ),
    );
  }
}
