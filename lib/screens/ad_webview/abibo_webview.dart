import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AbiboWebview extends StatefulWidget {
  const AbiboWebview({super.key});

  @override
  State<AbiboWebview> createState() => _AbiboWebviewState();
}

class _AbiboWebviewState extends State<AbiboWebview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse('https://play.google.com/store/search?q=abibo&c=apps'),
        ),
        initialOptions: InAppWebViewGroupOptions(
            android: AndroidInAppWebViewOptions(useHybridComposition: true)),
      ),
    );
  }
}
