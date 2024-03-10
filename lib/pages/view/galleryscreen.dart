import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite_v2/tflite_v2.dart';

// ignore: must_be_immutable
class GalleryScreen extends StatefulWidget {
  final String imagePath;
  CameraController? cameraController;

  GalleryScreen({
    super.key,
    required this.imagePath,
    this.cameraController,
  });

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late Future<void> _modelLoadingFuture;

  @override
  void initState() {
    super.initState();
    _modelLoadingFuture = Future.wait([initializeCamera(), loadModel()]);
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    // Use the first available camera
    final CameraController controller = CameraController(
      cameras[0],
      ResolutionPreset.medium,
    );
    widget.cameraController ??= controller;
    return controller.initialize();
  }

  Future<void> loadModel() async {
    await Tflite.loadModel(
      model: 'assets/images/tflite/model.tflite',
      labels: 'assets/images/tflite/labels.txt',
    );
  }

  @override
  void dispose() {
    Tflite.close();
    widget.cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Scanner'),
      ),
      body: FutureBuilder<void>(
        future: _modelLoadingFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ignore: unnecessary_null_comparison
                  widget.imagePath != null
                      ? Image.file(File(widget.imagePath), height: 200)
                      : CameraPreview(widget.cameraController!),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        XFile? picture =
                            await widget.cameraController?.takePicture();
                        if (picture != null) {
                          final results = await Tflite.runModelOnImage(
                            path: picture.path,
                          );
                          // Process the results as needed
                          showDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Model Results'),
                                content: Text('Model results: $results'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } catch (e) {
                        showDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: Text('Error running model: $e'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text('Scan Food'),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
