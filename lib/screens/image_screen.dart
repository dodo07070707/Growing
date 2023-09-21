import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ImageScreen extends StatefulWidget {
  const ImageScreen({super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  Map<String, List<String>> imagePathsByDate = {};
  String name = '';
  String memo = '';
  String enteredText = '';
  String daycountingText = '';
  DateTime selectedDate = DateTime.now();
  int daysRemaining = 0;
  String imagePath = '';

  @override
  void initState() {
    super.initState();
    _loadDataFromSharedPreferences();
    _loadBasicDataOfPictures();
    _loadImages();
  }

  Future<void> _loadImages() async {
    final appDir = await getApplicationDocumentsDirectory();
    final files = Directory(appDir.path).listSync();

    for (final file in files) {
      if (file is File && file.path.endsWith('.jpg')) {
        final fileName = file.path.split('/').last;
        final date = fileName.split('.').first;
        imagePathsByDate.putIfAbsent(date, () => []).add(file.path);
      }
    }

    setState(() {});
  }

  Future<void> _loadBasicDataOfPictures() async {
    final nowDate = DateTime.now();
    final appDir = await getApplicationDocumentsDirectory();
    final nowFormattedDate = DateFormat('yyyy-MM-dd').format(nowDate);
    imagePath = '${appDir.path}/$nowFormattedDate.jpg';
  }

  Future<void> _loadDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'No Data';
      memo = prefs.getString('memo') ?? '입력된 메모가 없습니다.';
      String selectedDateString = prefs.getString('date')!;
      selectedDate = DateTime.parse(selectedDateString);
      _calculateDaysRemaining();
    });
  }

  void _calculateDaysRemaining() {
    DateTime currentDate = DateTime.now();
    Duration difference = selectedDate.difference(currentDate);
    daysRemaining = difference.inDays;
    setState(() {
      if (daysRemaining == 0) {
        daycountingText = "D-Day";
      } else if (daysRemaining > 0) {
        daycountingText = "D+$daysRemaining";
      } else {
        daycountingText = "D$daysRemaining";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;
    final dateKeys = imagePathsByDate.keys.toList();
    String formattedSelectedDate =
        DateFormat('yyyy-MM-dd').format(selectedDate);
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
                    const Icon(Icons.arrow_back_ios_new,
                        size: 24, color: Colors.black),
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
                      daycountingText,
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
            Padding(
              padding: EdgeInsets.only(
                top: 0,
                right: screenWidth / 390 * 36,
                left: screenWidth / 390 * 36,
                bottom: 0,
              ),
              child: SizedBox(
                height: screenHeight / 844 * 514,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: dateKeys.length,
                        itemBuilder: (context, index) {
                          final date = dateKeys[index];
                          final imagePaths = imagePathsByDate[date];

                          return InkWell(
                            onTap: () {
                              // 해당 날짜의 이미지 목록 화면으로 이동
                              /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImageListByDate(imagePaths),
                                  ),
                                );*/
                              print('$imagePaths , $imagePath');
                            },
                            child: SizedBox(
                                height: screenHeight / 844 * 86,
                                width: screenWidth / 390 * 320,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: FileImage(
                                              File(imagePaths!.join(''))),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    // 투명도가 0.5인 검정색 Container
                                    Container(
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    // 텍스트를 배치
                                    Center(
                                      child: Text(
                                        date,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          color: Colors.white, // 텍스트 색상 설정
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
