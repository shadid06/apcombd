// import 'package:active_ecommerce_flutter/app_config.dart';
// import 'package:active_ecommerce_flutter/my_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// class Career extends StatefulWidget {
//   const Career({Key key}) : super(key: key);

//   @override
//   State<Career> createState() => _CareerState();
// }

// class _CareerState extends State<Career> {
//   final flutterWebViewPlugin = FlutterWebviewPlugin();
//   bool isLoading = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: MyTheme.appBarColor,
//         title: Text(
//           "Career",
//           style: TextStyle(color: MyTheme.appBarTextColor),
//         ),
//       ),
//       body: SafeArea(
//           child: WebviewScaffold(
//               url: "${AppConfig.RAW_BASE_URL}/career-page",
//               withLocalStorage: true,
//               withJavascript: true,
//               hidden: true,
//               initialChild: Container(
//                 child: const Center(
//                   child: CircularProgressIndicator(color: Colors.blueAccent),
//                 ),
//               ))),
//     );
//   }
// }

import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Career extends StatefulWidget {
  const Career({Key key}) : super(key: key);

  @override
  State<Career> createState() => _CareerState();
}

class _CareerState extends State<Career> {
  InAppWebViewController _webViewController;
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: MyTheme.appBarColor,
          title: Text(
            "Career",
            style: TextStyle(color: MyTheme.appBarTextColor),
          ),
        ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse("${AppConfig.RAW_BASE_URL}/career-page")),
              onWebViewCreated: (InAppWebViewController controller) {
                _webViewController = controller;
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  _progress = progress / 100;
                });
              },
            ),
            _progress < 1.0
                ? Center(
                    child: CircularProgressIndicator(
                      value: _progress,
                      color: MyTheme.accent_color,
                    ),
                  )
                : SizedBox()
          ],
        ));
  }
}
