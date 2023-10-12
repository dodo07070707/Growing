import 'package:flutter/material.dart';
import 'package:jinlo_project/themes/color_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jinlo_project/themes/text_theme.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:jinlo_project/screens/notice_screen.dart';
import 'package:jinlo_project/screens/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';
  String memo = '';
  String enteredText = '';
  String daycountingText = '';
  DateTime selectedDate = DateTime.now();
  int daysRemaining = 0;
  String staredDate = '';
  String filePath = '';

  @override
  void initState() {
    super.initState();
    _loadDataFromSharedPreferences();
    getFilePath();
  }

  Future<void> _loadDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'No Data';
      memo = prefs.getString('memo') ?? '입력된 메모가 없습니다.';
      staredDate = prefs.getString('staredDate') ?? 'No Stared Date';
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

  void _showMemoDialog() {
    Get.defaultDialog(
      title: '메모 수정하기',
      titleStyle: GRTextTheme.MainCardDescrb,
      titlePadding: const EdgeInsets.only(top: 20),
      content: SizedBox(
        height: 66,
        child: TextField(
          onChanged: (text) {
            enteredText = text;
          },
          cursorColor: GRColors.MAIN_THEME,
          decoration: const InputDecoration(
            labelText: ' ',
            helperText: '생물에 대한 메모를 적어주세요',
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: GRColors.MAIN_THEME,
              ),
            ),
          ),
        ),
      ),
      textConfirm: '확인',
      confirmTextColor: Colors.white,
      onConfirm: () {
        memo = enteredText;
        Get.back();
      },
      textCancel: '취소',
      cancelTextColor: GRColors.MAIN_THEME,
      onCancel: Get.back,
      buttonColor: GRColors.MAIN_THEME,
    );
  }

  Future<String> getFilePath() async {
    final Directory appDocumentDirectory =
        await getApplicationDocumentsDirectory();
    filePath = appDocumentDirectory.path;
    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;
    String formattedSelectedDate =
        DateFormat('yyyy-MM-dd').format(selectedDate);
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: screenWidth,
        height: screenHeight,
        child: Padding(
          padding: EdgeInsets.only(
            top: screenHeight / 844 * 30,
            bottom: 0,
            left: 0,
            right: 0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenWidth / 390 * 24),
                child: SizedBox(
                  height: screenHeight / 844 * 56,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: const Icon(
                          Icons.notifications_none_outlined,
                          size: 30,
                        ),
                        onTap: () {
                          Get.to(() => const NoticeScreen());
                        },
                      ),
                      Image.asset(
                        'assets/logos/logo_green.png',
                        width: 50,
                        height: 50,
                      ),
                      GestureDetector(
                        child: const Icon(
                          Icons.settings_outlined,
                          size: 30,
                        ),
                        onTap: () {
                          Get.to(() => const SettingScreen());
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight / 844 * 30),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenWidth / 390 * 36),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.numbers,
                              size: 24,
                              color: Colors.black,
                            ),
                            Text(
                              name,
                              style: GRTextTheme.MainCardDescrb,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.calendar_month,
                                size: 24, color: Colors.black),
                            const SizedBox(width: 2),
                            Text(daycountingText,
                                style: GRTextTheme.MainCardDescrb),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: screenHeight / 844 * 6),
                    Column(
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            child: Stack(
                              children: [
                                FutureBuilder(
                                    future: getFilePath(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Container(
                                          width: screenWidth / 390 * 330,
                                          height: screenWidth / 390 * 330,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15)),
                                            image: DecorationImage(
                                              image: FileImage(File(
                                                  '$filePath/$staredDate.jpg')),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      } else {
                                        return const Text('안돼');
                                      }
                                    }),
                                Container(
                                  width: screenWidth / 390 * 330,
                                  height: screenWidth / 390 * 330,
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(0, 0, 0, 0.5),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        GestureDetector(
                          onTap: () {
                            _showMemoDialog();
                          },
                          child: Container(
                            width: screenHeight / 844 * 330,
                            height: screenHeight / 844 * 120,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child:
                                  Text(memo, style: GRTextTheme.MainCardMemo),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight / 844 * 20),
                    Container(
                      // !광고
                      width: screenHeight / 844 * 330,
                      height: screenHeight / 844 * 78,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6B19DC),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(1),
                              border:
                                  Border.all(color: Colors.blue, width: 0.4),
                            ),
                            width: screenWidth / 390 * 30,
                            height: screenHeight / 844 * 20,
                            child: const Center(
                              child: Text(
                                'Ad',
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 12),
                              ),
                            ),
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/logos/ad/abibo_logo1.png',
                                  height: screenHeight / 844 * 30,
                                ),
                                SizedBox(
                                  width: screenWidth / 390 * 14,
                                ),
                                Image.asset(
                                  'assets/logos/ad/abibo_logo2.png',
                                  height: screenHeight / 844 * 30,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
