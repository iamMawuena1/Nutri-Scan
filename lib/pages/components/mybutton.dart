import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  const MyButton({
    super.key,
    required this.onTap,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
