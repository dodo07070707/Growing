import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jinlo_project/screens/splash_screen.dart';
import 'package:jinlo_project/screens/start_screen.dart';
import 'package:jinlo_project/screens/main_screen.dart';
import 'themes/color_theme.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _showSplashScreen = true;

  @override
  void initState() {
    super.initState();
    _loadData();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  Future<void> _loadData() async {
    await Future.delayed(
        const Duration(milliseconds: 2100)); // splash screen이 표시될 시간(초)
    setState(() {
      _showSplashScreen = false;
    });
  }

  Future<String?> getInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? Name = prefs.getString('name');
    return Name;
  }

  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Pretendard',
        colorScheme: const ColorScheme.light(
          background: Colors.white,
          brightness: Brightness.light,
        ),
        primaryColor: GRColors.MAIN_THEME,
      ),
      home: _showSplashScreen
          ? const Scaffold(body: SplashScreen())
          : FutureBuilder(
              future: getInfo(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                } else {
                  if (snapshot.data == null) {
                    return const StartScreen();
                  } else {
                    return const MainScreen();
                  }
                }
              },
            ),
    );
  }
}
