import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class ImageScreenByDate extends StatefulWidget {
  const ImageScreenByDate({
    Key? key,
    required this.imagePaths,
    required this.name,
    required this.date,
  }) : super(key: key);

  final List<String> imagePaths;
  final String name;
  final String date;

  @override
  State<ImageScreenByDate> createState() => _ImageScreenByDateState();
}

class _ImageScreenByDateState extends State<ImageScreenByDate> {
  /*Future<void> _saveStarToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String nowStared = nowStared.toString();

    await prefs.setString('name', name!);
  //!get snackbar
  }*/

  @override
  Widget build(BuildContext context) {
    final imagePaths = widget.imagePaths;
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;
    String name = widget.name;
    String date = widget.date;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: screenHeight / 844 * 64),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: screenWidth / 390 * 22),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back_ios_new,
                          size: 24, color: Colors.black),
                    ),
                    SizedBox(width: screenWidth / 390 * 6),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.calendar_month,
                        size: 24, color: Colors.black),
                    SizedBox(width: screenWidth / 390 * 4),
                    Text(
                      date,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                    ),
                    SizedBox(width: screenWidth / 390 * 22),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight / 844 * 150),
            Container(
              width: screenWidth / 390 * 318,
              height: screenWidth / 390 * 318,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(File(imagePaths.join(''))),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
