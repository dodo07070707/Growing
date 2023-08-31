import 'package:flutter/material.dart';

abstract class ABTextTheme {
  static const MenuBar = TextStyle(
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.bold,
    fontSize: 12,
    height: 1.2,
    color: Colors.black,
    letterSpacing: -0.4,
  );
  static final CopyrightText = TextStyle(
    color: Colors.white.withOpacity(0.7),
    fontSize: 12,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 1,
    letterSpacing: -0.4,
  );
}
