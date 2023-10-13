import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:growing/custom_text.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
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
                          text: '알림',
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
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: CustomText(
                      text: '알림 기능은 준비중에 있습니다!',
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  SizedBox(height: screenHeight / 844 * 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
