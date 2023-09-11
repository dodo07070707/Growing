import 'package:flutter/material.dart';

abstract class GRTextTheme {
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
  static const StartMainText = TextStyle(
    color: Colors.white,
    fontSize: 40,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w100,
    height: 1.2,
    letterSpacing: -0.4,
  );
  static const StartDescText = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.4,
  );
  static final StartRegiHintColor = TextStyle(
    color: Colors.white.withOpacity(0.5),
    fontSize: 18,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w700,
    height: 1.11,
  );
  static const MainCardDescrb = TextStyle(
    color: Colors.black,
    fontSize: 20,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 1,
  );
  static const MainCardMemo = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w400,
    height: 1,
  );
}
