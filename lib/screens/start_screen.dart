import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jinlo_project/themes/color_theme.dart';
import 'package:jinlo_project/themes/text_theme.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  String? name;
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate() async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ))!;
    setState(() {
      selectedDate = picked;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
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
            children: [
              Image.asset(
                'assets/logos/logo_white.png',
                width: 100,
                height: 100,
              ),
              SizedBox(height: screenHeight / 844 * 34),
              const Text('Growing', style: ABTextTheme.StartMainText),
              SizedBox(height: screenHeight / 844 * 40),
              const Text(
                '환영합니다\n키울 생물의 이름과\n처음 만난 날짜를 입력해주세요',
                style: ABTextTheme.StartDescText,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: screenHeight / 844 * 90),
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
                    hintStyle: ABTextTheme.StartRegiHintColor,
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
              SizedBox(height: screenHeight / 844 * 30),
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
                    hintStyle: ABTextTheme.StartRegiHintColor,
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
            ],
          ),
        ),
      ),
    );
  }
}
