import 'package:flutter/material.dart';

showSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.teal,
      content: Text(
        content,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
bool isValidUrl(String url) {
  RegExp urlRegExp = RegExp(
    r'^(https?://)?' // Optional scheme (http:// or https://)
    r'(([A-Z0-9-]+\.)+[A-Z]{2,63})' // Domain (example.com)
    r'(/[-a-zA-Z0-9+&@#/%?=~_|!:,.;]*[-a-zA-Z0-9+&@#/%=~_|])?' // Optional path
    r'$', // End of string
    caseSensitive: false, // Case-insensitive matching
  );
  return urlRegExp.hasMatch(url);
}