import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({super.key});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(
              'https://opaque-sun-948.notion.site/Growing-cc76ca21841541a8a8afc7486c7e2e79?pvs=4'),
        ),
        initialOptions: InAppWebViewGroupOptions(
            android: AndroidInAppWebViewOptions(useHybridComposition: true)),
      ),
    );
  }
}
