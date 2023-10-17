import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growing/static.dart';
import 'package:growing/screens/webview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:growing/custom_text.dart';
import 'package:growing/screens/notifications.dart';
import 'package:growing/screens/custom_switch_button.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

Future<void> resetSharedPreferences() async {
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
  bool entireNotificationenable = false;
  late SharedPreferences prefs;
  Future<bool> getEntireNotificationenable() async {
    prefs = await SharedPreferences.getInstance();
    entireNotificationenable =
        prefs.getBool('entireNotificationenable') ?? true;
    setState(() {});
    print(entireNotificationenable);
    return entireNotificationenable;
  }

  @override
  void initState() {
    super.initState();
    getEntireNotificationenable();
  }

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
                    Column(
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
                            CustomText(
                              text: 'ON',
                              style: TextStyle(
                                color: entireNotificationenable
                                    ? Colors.black
                                    : const Color(0xFF000000).withOpacity(0.3),
                                fontSize: 18,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w400,
                                height: 1.25,
                              ),
                            ),
                            const SizedBox(width: 10),
                            CustomSwitchButton(
                              value: entireNotificationenable,
                              onChanged: (value) async {
                                if (value) {
                                  await setNotification();
                                } else {
                                  await unsetNotification();
                                }
                                await prefs.setBool(
                                    'entireNotificationenable', value);

                                setState(() {
                                  entireNotificationenable = value;
                                });
                              },
                            ),
                            const SizedBox(width: 10),
                            CustomText(
                              text: 'OFF',
                              style: TextStyle(
                                color: entireNotificationenable
                                    ? Colors.black.withOpacity(0.3)
                                    : Colors.black,
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
