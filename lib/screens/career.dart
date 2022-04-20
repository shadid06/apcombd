import 'dart:async';
import 'dart:io';

import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:modal_progress_hud/modal_progress_hud.dart';

class Career extends StatefulWidget {
  const Career({Key key}) : super(key: key);

  @override
  State<Career> createState() => _CareerState();
}

class _CareerState extends State<Career> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  bool isLoading = true;

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
      body: SafeArea(
          child: WebviewScaffold(
              url: "${AppConfig.RAW_BASE_URL}/career-page",
              withLocalStorage: true,
              hidden: true,
              initialChild: Container(
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.blueAccent),
                ),
              ))),
    );
  }
}
