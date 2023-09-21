import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jinlo_project/screens/main_screen.dart';
import 'package:jinlo_project/themes/color_theme.dart';
import 'package:jinlo_project/themes/text_theme.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  String? name;
  DateTime? selectedDate;

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: GRColors.MAIN_THEME,
              onPrimary: Colors.white,
              onSurface: GRColors.MAIN_THEME,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: GRColors.MAIN_THEME,
                backgroundColor: Colors.white,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _saveDataToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String selecteddDateString = selectedDate.toString();

    await prefs.setString('name', name!);
    await prefs.setString('date', selecteddDateString);
    await prefs.setString('staredDate', '');

    Get.offAll(() => const MainScreen());
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          color: GRColors.MAIN_THEME,
          child: Padding(
            padding: EdgeInsets.only(
              top: screenHeight / 844 * 128,
              bottom: screenHeight / 844 * 54,
              left: screenWidth / 390 * 40,
              right: screenWidth / 390 * 40,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/logos/logo_white.png',
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(height: screenHeight / 844 * 10),
                    const Text('Growing', style: GRTextTheme.StartMainText),
                    SizedBox(height: screenHeight / 844 * 40),
                    const Text(
                      '환영합니다\n키울 생물의 이름과\n처음 만난 날짜를 입력해주세요',
                      style: GRTextTheme.StartDescText,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: screenHeight / 844 * 80),
                    SizedBox(
                      height: 21,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            name = value.toLowerCase().removeAllWhitespace;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "이름 입력",
                          hintStyle: GRTextTheme.StartRegiHintColor,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: GRColors.Regi_Hint_Color,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: GRColors.Regi_Hint_Color,
                              width: 1.5,
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          // 입력중 text color
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight / 844 * 20),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: _selectDate,
                        child: Center(
                          child: Text(
                            (selectedDate != null)
                                ? DateFormat('yyyy년 MM월 dd일')
                                    .format(selectedDate!)
                                : "날짜 선택",
                            style: const TextStyle(color: GRColors.MAIN_THEME),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  child: Container(
                    height: screenHeight / 844 * 66,
                    width: screenWidth,
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text(
                        '다음으로',
                        style: TextStyle(
                          color: Color(0xFF00B375),
                          fontSize: 18,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    _saveDataToSharedPreferences();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
