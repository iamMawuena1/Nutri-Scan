import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CustomSlider extends StatelessWidget {
  final double percent;
  final String text;
  const CustomSlider({
    super.key,
    required this.percent,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        LinearPercentIndicator(
          barRadius: const Radius.circular(10),
          animation: true,
          animationDuration: 1500,
          lineHeight: 25,
          percent: percent,
          progressColor: Colors.red,
          backgroundColor: Colors.grey.shade100,
        ),
      ],
    );
  }
}
