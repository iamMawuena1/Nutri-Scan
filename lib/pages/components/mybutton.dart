import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final Widget child;
  final double width;
  final Color? color;
  final double? height;
  final EdgeInsetsGeometry? padding;
  const MyButton({
    super.key,
    required this.onTap,
    required this.child,
    this.padding,
    required this.width,
    required this.color,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
