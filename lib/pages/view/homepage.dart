// class HomePage extends StatelessWidget {
import 'package:flutter/material.dart';
import 'package:nutriscan_app/pages/components/mybutton.dart';
import 'package:nutriscan_app/pages/screens/carousel.dart';
import 'package:nutriscan_app/pages/view/camera.dart';
import 'package:nutriscan_app/pages/view/galleryscreen.dart';

import '../components/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF860D9A),
        title: const Text(
          'Camera',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          const CarouselPage(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //Camera button
              Expanded(
                child: MyButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CameraScreen(),
                      ),
                    );
                  },
                  width: 150,
                  padding: const EdgeInsets.all(20),
                  color: Colors.deepPurple,
                  child: Text(
                    'Camera',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),

              //gallery button
              Expanded(
                child: MyButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GalleryScreen(),
                      ),
                    );
                  },
                  width: 150,
                  padding: const EdgeInsets.all(20),
                  color: Colors.deepPurple,
                  child: Text(
                    'Gallery',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
