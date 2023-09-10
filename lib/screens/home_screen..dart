import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jinlo_project/themes/text_theme.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';
  DateTime selectedDate = DateTime.now();
  int daysRemaining = 0;

  @override
  void initState() {
    super.initState();
    _loadDataFromSharedPreferences();
  }

  Future<void> _loadDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'No Data';
      String selectedDateString = prefs.getString('date')!;
      selectedDate = DateTime.parse(selectedDateString);
      _calculateDaysRemaining();
    });
  }

  void _calculateDaysRemaining() {
    DateTime currentDate = DateTime.now();
    Duration difference = selectedDate.difference(currentDate);
    daysRemaining = difference.inDays;
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
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight / 844 * 16),
              Container(
                width: screenWidth / 390 * 390,
                height: screenHeight / 844 * 78,
                decoration: const BoxDecoration(
                  color: Color(0xFFD9D9D9),
                ),
                child: const Center(
                  child: Text(
                    '광고 위치',
                    style: TextStyle(color: Colors.black, fontSize: 20),
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
                                style: ABTextTheme.MainCardDescrb,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.calendar_month,
                                  size: 24, color: Colors.black),
                              const SizedBox(width: 2),
                              Text('D-$daysRemaining',
                                  style: ABTextTheme.MainCardDescrb),
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
                            child: Image.asset('assets/exampleimg.jpg',
                                width: 318, height: 318),
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
