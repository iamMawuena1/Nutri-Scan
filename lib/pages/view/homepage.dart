// class HomePage extends StatelessWidget {
import 'package:flutter/material.dart';
import 'package:nutriscan_app/pages/view/galleryscreen.dart';

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
        title: const Text('Camera'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //Camera button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'camera');
              },
              child: const Text('Camera'),
            ),
            //gallery button
            ElevatedButton(
                child: const Text("Gallery"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GalleryScreen(),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
