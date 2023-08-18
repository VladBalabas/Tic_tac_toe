import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoInternetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You have no internet connection',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Try reload app',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}