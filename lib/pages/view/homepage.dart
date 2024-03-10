// class HomePage extends StatelessWidget {
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutriscan_app/pages/view/camera.dart';
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CameraScreen(),
                  ),
                );
              },
              child: const Text('Camera'),
            ),
            ElevatedButton(
              onPressed: () async {
                final image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (image != null) {
                  Navigator.push(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          GalleryScreen(imagePath: image.path),
                    ),
                  );
                }
              },
              child: const Text('Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}
