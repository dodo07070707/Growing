import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jinlo_project/themes/text_theme.dart';

class PhotoPreview extends StatelessWidget {
  final String imagePath;

  const PhotoPreview({required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(
            top: screenHeight / 844 * 76,
            right: screenWidth / 390 * 36,
            left: screenWidth / 390 * 36,
            bottom: 0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '사진 확인',
                    style: GRTextTheme.TitleMiddle,
                  ),
                  SizedBox(height: screenHeight / 844 * 80),
                  SizedBox(
                    // !이미지
                    width: screenWidth / 390 * 318,
                    height: screenWidth / 390 * 318,
                    child: Image.file(
                      File(imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: screenHeight / 844 * 12),
                  const Text(
                    '사진이 찍혔습니다! 마음에 드시나요?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      height: 1,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: screenHeight / 844 * 64,
                    width: screenWidth / 390 * 318,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: const Text(
                      '다시 촬영하기',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      color: Color(0xFFE81B00),
                      fontSize: 18,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 1,
                    ),
                    ),
                  SizedBox(height: screenHeight / 844 * 128),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
