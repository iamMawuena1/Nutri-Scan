import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:nutriscan_app/pages/screens/login.dart';
import 'package:nutriscan_app/pages/screens/signup.dart';
import 'package:nutriscan_app/pages/view/camera.dart';
import 'package:nutriscan_app/pages/view/galleryscreen.dart';
import 'package:nutriscan_app/pages/view/homepage.dart';
import 'package:nutriscan_app/pages/view/onboarding.dart';
import 'package:nutriscan_app/pages/view/splashcreen.dart';

//list of cameras available on the device
List<CameraDescription>? cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
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
        '/camera': (context) => const CameraScreen(),
        '/gallery': (context) => const GalleryScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
      },
      home: const SplashScreen(),
    );
  }
}
