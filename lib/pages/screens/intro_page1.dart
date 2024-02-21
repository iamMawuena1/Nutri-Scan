import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF860D9A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Image.asset(
              "images/onboarding1.png",
              width: 500,
            ),
            //const SizedBox(height: 5),
            // description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Have control over what you eat with NutriScan, it just got easier",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
