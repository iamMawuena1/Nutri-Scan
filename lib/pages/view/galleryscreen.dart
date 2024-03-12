import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutriscan_app/pages/components/drawer.dart';
import 'package:tflite_v2/tflite_v2.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  File? pickedImage;
  bool isImageLoaded = false;
  List? results;

  @override
  void initState() {
    super.initState();

    isImageLoaded = true;

    loadMyModel().then((value) {
      setState(() {
        isImageLoaded = false;
      });
    });
  }

  Future getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImageFile =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImageFile == null) return;

    setState(() {
      pickedImage = File(pickedImageFile.path);
      isImageLoaded = true;
    });

    // Call applyImageOnModel to run the model on the selected image
    await applyImageOnModel(pickedImage!);
  }

  Future<void> applyImageOnModel(File file) async {
    var res = await Tflite.runModelOnImage(
      path: file.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      isImageLoaded = false;
      results = res;
    });
  }

  Future<void> loadMyModel() async {
    await Tflite.loadModel(
      model: "images/model_unquant.tflite",
      labels: "images/labels.txt",
      numThreads: 1,
      isAsset: true,
      // useGpuDelegate: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF860D9A),
        title: const Text(
          'Scan From Gallery',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: const CustomDrawer(),
      body: isImageLoaded
          ? Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            )
          : SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  pickedImage == null ? Container() : Image.file(pickedImage!),
                  const SizedBox(height: 20),
                  results != null
                      ? Text(
                          "${results![0]["label"]}",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20.0),
                        )
                      : Container(),
                  const Spacer(),
                  //Gallery button
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Color(0xFF860D9A),
                            ),
                          ),
                          onPressed: () async => await getImageFromGallery(),
                          child: const Text(
                            "Pick From Gallery",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
