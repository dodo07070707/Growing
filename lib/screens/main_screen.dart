import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:jinlo_project/screens/camera_screen.dart';
import 'package:jinlo_project/screens/home_screen..dart';
import 'package:jinlo_project/screens/image_screen.dart';
import 'package:get/get.dart';
import 'package:jinlo_project/themes/color_theme.dart';
import 'package:event_bus/event_bus.dart';
import 'package:jinlo_project/themes/text_theme.dart';

//! preview에서 back칠때 myController.isButtonPressed.value 값 변경
//! notchbar 말고 icon에서만 눌림

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pageController = PageController(initialPage: 0);
  final _controller = NotchBottomBarController(index: 0);
  final MyController myController = Get.put(MyController());
  int maxCount = 5;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> bottomBarPages = [
    const HomeScreen(),
    const CameraScreen(),
    const ImageScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              notchBottomBarController: _controller,
              color: Colors.white,
              showLabel: true,
              notchColor: GRColors.MAIN_THEME,
              removeMargins: false,
              bottomBarWidth: 500,
              durationInMilliSeconds: 50,
              itemLabelStyle: GRTextTheme.BottomBarLabel,
              bottomBarItems: [
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_filled,
                    color: Color(0xFFB3B3b3),
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                    color: Colors.white,
                  ),
                  itemLabel: '홈',
                ),
                BottomBarItem(
                  inActiveItem: const Icon(
                    Icons.camera_alt_outlined,
                    color: Color(0xFFB3B3b3),
                  ),
                  activeItem: GestureDetector(
                    onTap: () {
                      myController.toggleButtonState();
                      print('pressed');
                      print(myController.isButtonPressed.value);
                      if (myController.isButtonPressed.value) {
                        eventBus.fire(MyEvent());
                      }
                    },
                    child: Image.asset(
                      'assets/logos/logo_white.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  itemLabel: '카메라',
                ),
                const BottomBarItem(
                  inActiveItem: Icon(
                    Icons.image_outlined,
                    color: Color(0xFFB3B3B3),
                  ),
                  activeItem: Icon(
                    Icons.image_outlined,
                    color: Colors.white,
                  ),
                  itemLabel: '이미지',
                ),
              ],
              onTap: (index) {
                _pageController.jumpToPage(index);
              },
            )
          : null,
    );
  }
}

class MyController extends GetxController {
  var isButtonPressed = false.obs;

  void toggleButtonState() {
    isButtonPressed.value = !isButtonPressed.value;
  }
}

final eventBus = EventBus();
