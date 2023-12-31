import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'camera_result_screen.dart';
import 'main_screen.dart';
import 'package:get/get.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? _cameraController;
  bool _isCameraReady = false;

  @override
  void initState() {
    super.initState();

    eventBus.on<MyEvent>().listen((event) {
      _onTakePicture(context);
    });

    availableCameras().then((cameras) {
      if (cameras.isNotEmpty && _cameraController == null) {
        _cameraController = CameraController(
          cameras.first,
          ResolutionPreset.ultraHigh,
        );

        _cameraController!.initialize().then((_) {
          _cameraController!.setFlashMode(FlashMode.off);
          setState(() {
            _isCameraReady = true;
          });
        });
      }
    });
  }

  void _onTakePicture(BuildContext context) async {
    if (_cameraController != null) {
      try {
        Get.snackbar('알림', '사진이 찍히고 있습니다. 기기를 움직이지 말고 잠시만 기다려주세요');
        final XFile image = await _cameraController!.takePicture();
        if (image != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PhotoPreview(
                imagePath: image.path,
              ),
            ),
          );
        } else {
          print('사진 촬영 실패');
        }
      } catch (e) {
        print('사진 촬영 중 오류 발생: $e');
      }
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: [
            SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: _cameraController != null && _isCameraReady
                  ? CameraPreview(_cameraController!)
                  : Container(
                      color: Colors.grey,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyEvent {}
