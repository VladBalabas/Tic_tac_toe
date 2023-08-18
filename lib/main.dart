import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/src/checker.dart';
import 'package:tic_tac_toe/src/white/initial_page.dart';

import 'src/black/black.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String state = prefs.getString("state") ?? "";

  runApp(MaterialApp(
    home: state == "black" ? WebViewApp() : state == "white" ? InitialPage() : Checker(),
    debugShowCheckedModeBanner: false,
    // initialRoute: "/black",
    // routes: {
    //   '/': (context) => const Checker(),
    //   '/black': (context) => const WebViewApp(),
    //   '/white': (context) => MenuScreen(),
    // },
  ));
}

