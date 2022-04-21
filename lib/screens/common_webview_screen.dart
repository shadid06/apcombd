import 'dart:async';

import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';

class CommonWebviewScreen extends StatefulWidget {
  String url;
  String page_name;

  CommonWebviewScreen({Key key, this.url = "", this.page_name = ""})
      : super(key: key);

  @override
  _CommonWebviewScreenState createState() => _CommonWebviewScreenState();
}

class _CommonWebviewScreenState extends State<CommonWebviewScreen> {
  // WebViewController _webViewController;
  // final Completer<WebViewController> _controller =
  //     Completer<WebViewController>();
  // bool isLoading = true;
  InAppWebViewController _webViewController;
  double _progress = 0.0;
  @override
  void initState() {
    super.initState();
    // WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(context),
        body: buildBodyNew(),
      ),
    );
  }

  // buildBody() {
  //   return SizedBox.expand(
  //     child: ModalProgressHUD(
  //       inAsyncCall: isLoading,
  //       child: WebView(
  //         debuggingEnabled: false,
  //         javascriptMode: JavascriptMode.unrestricted,
  //         onWebViewCreated: (controller) {
  //           _webViewController = controller;
  //           _webViewController.loadUrl(widget.url);
  //         },
  //         onWebResourceError: (error) {},
  //         onPageFinished: (page) {
  //           //print(page.toString());
  //           setState(() {
  //             isLoading = false;
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }

  buildBodyNew() {
    return SizedBox.expand(
        child: Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
          onWebViewCreated: (InAppWebViewController controller) {
            _webViewController = controller;
          },
          onProgressChanged: (InAppWebViewController controller, int progress) {
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
        "${widget.page_name}",
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
