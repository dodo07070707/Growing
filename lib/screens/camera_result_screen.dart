import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jinlo_project/themes/color_theme.dart';
import 'package:jinlo_project/themes/text_theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PhotoPreview extends StatelessWidget {
  final String imagePath;

  const PhotoPreview({required this.imagePath, super.key});

  Future<void> saveImage() async {
    final nowDate = DateTime.now();
    final nowFormattedDate = DateFormat('yyyy-MM-dd').format(nowDate);
    // 이미지를 앱의 로컬 디렉토리에 저장하기 위한 경로 가져오기
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = '$nowFormattedDate.jpg'; //!여기 수정
    final localImage = File('${appDir.path}/$fileName');

    // 이미지 복사
    await File(imagePath).copy(localImage.path);

    // 이미지 저장 완료 메시지 표시
    Get.snackbar(
      '알림',
      '저장 완료.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

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
                  GestureDetector(
                    child: Container(
                      height: screenHeight / 844 * 64,
                      width: screenWidth / 390 * 318,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                            spreadRadius: 0,
                            offset: const Offset(4, 4),
                          )
                        ],
                      ),
                      child: const Center(
                        child: Text(
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
                      ),
                    ),
                    onTap: () async {
                      //Get.to()
                    },
                  ),
                  SizedBox(height: screenHeight / 844 * 18),
                  GestureDetector(
                    child: Container(
                      height: screenHeight / 844 * 64,
                      width: screenWidth / 390 * 318,
                      decoration: BoxDecoration(
                          color: GRColors.MAIN_THEME,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 4,
                              spreadRadius: 0,
                              offset: const Offset(4, 4),
                            )
                          ]),
                      child: const Center(
                        child: Text(
                          '다음으로 !',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                    onTap: () async {
                      await saveImage();
                      Get.snackbar('성공', 'ㅁㄴㅇㄹ',
                          duration: const Duration(seconds: 2));
                    },
                  ),
                  SizedBox(height: screenHeight / 844 * 110),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
