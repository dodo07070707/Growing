import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growing/themes/color_theme.dart';
import 'package:growing/static.dart';
import 'package:growing/screens/webview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:growing/custom_text.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

Future<void> resetSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

void _showAlert(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: const CustomText(text: "초기화"),
        content: const CustomText(text: "모든 데이터를 삭제하시겠습니까?"),
        actions: [
          CupertinoDialogAction(
            child: const CustomText(text: "예"),
            onPressed: () {
              resetSharedPreferences();
              Navigator.of(context).pop();
              Get.snackbar(
                '알림',
                '초기화가 완료되었습니다.',
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(seconds: 2),
              );
            },
          ),
          CupertinoDialogAction(
            child: const CustomText(text: "아니요"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight / 844 * 64),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: screenWidth / 390 * 22),
                        GestureDetector(
                          child: const Icon(Icons.arrow_back_ios_new,
                              size: 24, color: Colors.black),
                          onTap: () {
                            Get.back();
                          },
                        ),
                        SizedBox(width: screenWidth / 390 * 6),
                        const CustomText(
                          text: '설정',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: screenHeight / 844 * 56),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: screenWidth / 390 * 34),
                    GestureDetector(
                      onTap: () {
                        Get.snackbar(
                          '알림',
                          '알림 기능은 구현중입니다.',
                          duration: const Duration(seconds: 2),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            text: '알림',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 1.25,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight / 844 * 6,
                          ),
                          Row(
                            children: [
                              const CustomText(
                                text: 'ON',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  height: 1.25,
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: screenWidth / 390 * 50,
                                height: screenHeight / 844 * 26,
                                child: Container(
                                  width: 52.0,
                                  height: 28.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24.0),
                                      color: const Color(0xFFC2FFEA)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 2.0,
                                      bottom: 2.0,
                                      right: 2.0,
                                      left: 2.0,
                                    ),
                                    child: Container(
                                      alignment: ((Directionality.of(context) ==
                                              TextDirection.rtl)
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft),
                                      child: Container(
                                        width: 20.0,
                                        height: 20.0,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: GRColors.MAIN_THEME,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              CustomText(
                                text: 'OFF',
                                style: TextStyle(
                                  color: Colors.black
                                      .withOpacity(0.30000001192092896),
                                  fontSize: 18,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  height: 1.25,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight / 844 * 20),
                Container(
                  width: screenWidth,
                  height: 1,
                  decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
                ),
                SizedBox(height: screenHeight / 844 * 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: screenWidth / 390 * 34),
                    Column(
                      children: [
                        const CustomText(
                          text: '앱 버전',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                        SizedBox(height: screenHeight / 844 * 6),
                        const CustomText(
                          text: 'V. ${GrowingStatic.AppVersion}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: screenHeight / 844 * 20),
                Container(
                  width: screenWidth,
                  height: 1,
                  decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
                ),
                SizedBox(height: screenHeight / 844 * 20),
                Row(
                  children: [
                    SizedBox(width: screenWidth / 390 * 34),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const WebviewScreen());
                      },
                      child: const CustomText(
                        text: '이용약관',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 1.25,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight / 844 * 20),
                Container(
                  width: screenWidth,
                  height: 1,
                  decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
                ),
                SizedBox(height: screenHeight / 844 * 20),
                Row(
                  children: [
                    SizedBox(width: screenWidth / 390 * 34),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const WebviewScreen());
                      },
                      child: const CustomText(
                        text: '개인정보처리약관',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 1.25,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: screenHeight / 844 * 20),
                Container(
                  width: screenWidth,
                  height: 1,
                  decoration: const BoxDecoration(color: Color(0xFFD9D9D9)),
                ),
                SizedBox(height: screenHeight / 844 * 20),
                Row(
                  children: [
                    SizedBox(width: screenWidth / 390 * 34),
                    GestureDetector(
                      onTap: () {
                        _showAlert(context);
                      },
                      child: const CustomText(
                        text: '전체 삭제 / 초기화',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 1.25,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
