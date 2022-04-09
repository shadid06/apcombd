import 'dart:async';

import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions();

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: WebView(
          initialUrl: 'https://www.apcombd.com/terms-conditions-page',
          // javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (finished) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      // backgroundColor: Colors.white,
      backgroundColor: MyTheme.appBarColor,
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Text(
        "Terms and Conditions",
        style: TextStyle(
          fontSize: 16,
          //  color: MyTheme.accent_color
          color: MyTheme.appBarTextColor,
        ),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }
}
