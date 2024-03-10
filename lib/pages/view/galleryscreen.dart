import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tflite_v2/tflite_v2.dart';

class GalleryScreen extends StatefulWidget {
  final String imagePath;

  const GalleryScreen({super.key, required this.imagePath});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  late Future<void> _modelLoadingFuture;

  @override
  void initState() {
    super.initState();
    _modelLoadingFuture = loadModel();
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
                  Image.file(File(widget.imagePath), height: 200),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final results = await Tflite.runModelOnImage(
                          path: widget.imagePath,
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
                      } catch (e) {
                        showDialog(
                          // ignore: use_build_context_synchronously
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Error'),
                              content: Text('Error running model on image: $e'),
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
