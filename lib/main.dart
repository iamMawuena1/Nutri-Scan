import 'package:flutter/material.dart';
import 'package:nutriscan_app/pages/homepage.dart';
import 'package:nutriscan_app/pages/onboarding.dart';
import 'package:nutriscan_app/pages/screens/login.dart';
import 'package:nutriscan_app/pages/screens/signup.dart';

import 'pages/splashcreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      routes: {
        '/homepage': (context) => const HomePage(),
        '/onboarding': (context) => const OnboardingPage(),
        '/splashscreen': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
      },
      home: const SplashScreen(),
    );
  }
}
