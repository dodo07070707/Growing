import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'camera_result_screen.dart';
import 'main_screen.dart';

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
        final XFile image = await _cameraController!.takePicture();
        if (image != null) {
          // 사진 촬영이 완료되면 미리보기 화면으로 이동
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
            /*Positioned(
              bottom: screenHeight / 844 * 60,
              right: screenWidth / 390 * 160,
              child: Container(
                height: 60.1,
                width: 60.1,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 4,
                      offset: const Offset(0, 0),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.white,
                      fixedSize: const Size(60, 60)),
                  onPressed: _cameraController != null
                      ? () => _onTakePicture(context)
                      : null,
                  child: const Text(''),
                ),
              ),
            ),
            
            Positioned(
              top: 0,
              left: 0,
              child: GestureDetector(
                  child: const Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  onTap: () {
                    () => Get.back();
                  }),
            ), // 사용하지 않음
            */
          ],
        ),
      ),
    );
  }
}

class MyEvent {}
