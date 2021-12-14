import 'package:flutter/material.dart';

abstract class Style {
  static const button = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 1.5,
  );

  static const information = TextStyle(
    color: Colors.white,
    fontSize: 17,
  );
}