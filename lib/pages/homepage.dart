import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutriscan_app/pages/components/app_image_puicker.dart';
import 'package:nutriscan_app/pages/components/camer_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? image;

  pickImage(ImageSource source) {
    AppImagePicker(source: source).pick(onPick: (File? image) {
      setState(() {
        this.image = image;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF860D9A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Camera"),
      ),
      body: Column(
        children: [
          if (image != null) Image.file(image!),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MediaButton(
                text: 'Camera',
                icon: Icons.camera_alt,
                onTap: () => pickImage(ImageSource.camera),
              ),
              MediaButton(
                text: "Gallery",
                icon: Icons.file_copy_rounded,
                onTap: () => pickImage(ImageSource.gallery),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
