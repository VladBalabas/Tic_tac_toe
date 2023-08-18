import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final double width;
  final double height;
  final Widget child;
  const MyButton({super.key, required this.onTap,required this.child, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
              onTap: onTap,
            child: Center(
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFE1F0C4)
                ),
                padding: EdgeInsets.all(10),
                child: Center(child: child,)
                ),
            )
            );
  }
}