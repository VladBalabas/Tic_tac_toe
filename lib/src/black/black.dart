import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';


import 'navigation_controls.dart';
import 'no_internet_cinnection.dart';

class WebViewApp extends StatefulWidget {
  const WebViewApp({Key? key}) : super(key: key);

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    // OneSignal
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId("8a879830-4a19-4afb-803a-465d90290783");
    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {});

    getSavedCookies();
    getSavedLink();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            print("Started onPageStart");
          },
          onPageFinished: (String url) async {
            final String cookies = await controller
                .runJavaScriptReturningResult('document.cookie') as String;

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("cookies", cookies);
          },
          onWebResourceError: (WebResourceError error) async {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NoInternetPage(),));
          },
        ),
      );
  }
  void getSavedLink() async {
    await SharedPreferences.getInstance();
    String link = "https://quinzik.com";
    try {
      controller.loadRequest(Uri.parse(link));
    } catch (e) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NoInternetPage(),));
    }
  }

  void getSavedCookies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedCookies = prefs.getString("cookies");
    await controller.runJavaScript('document.cookie = "$savedCookies";');
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text("Saved cookies: $savedCookies"),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        left: false,
        right: false,
        bottom: false,
        child: Stack(
          children: [
            WebViewWidget(controller: controller),
            NavigationControls(controller: controller),
          ],
        ),
      ),
    );
  }
}