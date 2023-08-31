import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jinlo_project/themes/color_theme.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return GetMaterialApp(
      home: Container(
        color: GRColors.MAIN_THEME,
        child: Padding(
          padding: EdgeInsets.only(
            top: screenHeight / 844 * 128,
            bottom: screenHeight / 844 * 54,
            left: screenHeight / 390 * 40,
            right: screenHeight / 390 * 40,
          ),
          child: const Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
