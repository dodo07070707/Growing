import 'package:flutter/material.dart';
import 'package:growing/themes/color_theme.dart';
import 'package:growing/themes/text_theme.dart';
import 'package:growing/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: GRColors.MAIN_THEME,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(height: screenHeight / 844 * 358),
                Image.asset(
                  'assets/logos/logo_white.png',
                  width: 128,
                  height: 128,
                ),
                SizedBox(height: screenHeight / 844 * 24),
              ],
            ),
            Column(
              children: [
                CustomText(
                  text: 'Copyright 2023. Growing All rights reserved',
                  textAlign: TextAlign.center,
                  style: GRTextTheme.CopyrightText,
                ),
                SizedBox(height: screenHeight / 844 * 65),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
