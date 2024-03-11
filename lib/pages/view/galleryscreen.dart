// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:nutriscan_app/pages/components/mybutton.dart';
// import 'package:tflite_v2/tflite_v2.dart';

// class GalleryScreen extends StatefulWidget {
//   const GalleryScreen({super.key});

//   @override
//   State<GalleryScreen> createState() => _GalleryScreenState();
// }

// class _GalleryScreenState extends State<GalleryScreen> {
//   File? pickImage;
//   bool isImageLoaded = false;

//   List? results;
//   String? confidence;
//   String? name = '';
//   String? numbers = '';

//   Future getImageFromGallery() async {
//     final tempStore =
//         await ImagePicker().pickImage(source: ImageSource.gallery);
//     if (tempStore == null) return;
//     setState(() {
//       pickImage = File(tempStore.path);
//       isImageLoaded = true;
//     });

//     // Call applyImageOnModel to run the model on the selected image
//     await applyImageOnModel(pickImage!);
//   }

//   //apply the imgae on the trained
//   Future<void> applyImageOnModel(File file) async {
//     var res = await Tflite.runModelOnImage(
//       path: file.path,
//       numResults: 2,
//       threshold: 0.5,
//       imageMean: 127.5,
//       imageStd: 127.5,
//     );

//     if (res != null && res.isNotEmpty) {
//       setState(() {
//         results = res;
//         String str = results![0]["labels"];
//         name = str.substring(2);
//         confidence = results != null
//             ? "${(results![0]['confidence'] * 100.0).toString().substring(0, 2)}%"
//             : "";
//       });
//     }
//   }

//   Future<void> loadMyModel() async {
//     var resultant = await Tflite.loadModel(
//       model: "images/model_unquant.tflite",
//       labels: "images/labels.txt",
//       numThreads: 1,
//       isAsset: true,
//       useGpuDelegate: true,
//     );
//     print("Results after scan is $resultant");
//   }

//   @override
//   void initState() {
//     loadMyModel();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Scan From Gallery'),
//       ),
//       body: Column(
//         children: [
//           const SizedBox(
//             height: 30,
//           ),
//           isImageLoaded
//               ? Center(
//                   child: Container(
//                     height: 320,
//                     width: 320,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: FileImage(File(pickImage!.path)),
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
//                 )
//               : Container(),
//           const SizedBox(height: 30),
//           Text("Name : $name \nConfidence : $confidence"),
//           const Spacer(),
//           MyButton(
//             onTap: () async => await getImageFromGallery(),
//             child: const Text("Pick From Gallery"),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutriscan_app/pages/components/mybutton.dart';
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
  String? confidence;
  String? name = '';

  List<String> labels = [];

  @override
  void initState() {
    super.initState();
    loadMyModel();
  }

  Future getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImageFile == null) return;

    setState(() {
      pickedImage = File(pickedImageFile.path);
      isImageLoaded = true;
    });

    // Call applyImageOnModel to run the model on the selected image
    await applyImageOnModel(pickedImage!);
  }

  Future<void> applyImageOnModel(File file) async {
    try {
      var res = await Tflite.runModelOnImage(
        path: file.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5,
      );

      if (res != null && res.isNotEmpty) {
        setState(() {
          results = res;
          String label = results![0]["labels"] ?? "";
          int index = int.parse(label.split(' ')[0]);
          name = labels[index];
          confidence = results != null
              ? "${(results![0]['confidence'] * 100.0).toStringAsFixed(2)}%"
              : "";
        });
      }
    } catch (e) {
      print("Error running model: $e");
    }
  }

  Future<void> loadMyModel() async {
    try {
      var resultant = await Tflite.loadModel(
        model: "images/model_unquant.tflite",
        labels: "images/labels.txt",
        numThreads: 1,
        isAsset: true,
        useGpuDelegate: true,
      );
      print("Results after scan is $resultant");

      // Load labels into the list
      labels = await File("images/labels.txt").readAsLines();
    } catch (e) {
      print("Error loading model: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan From Gallery'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          isImageLoaded
              ? Center(
                  child: Container(
                    height: 320,
                    width: 320,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(pickedImage!),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                )
              : Container(),
          const SizedBox(height: 30),
          Text("Name : $name \nConfidence : $confidence"),
          const Spacer(),
          MyButton(
            onTap: () async => await getImageFromGallery(),
            child: const Text("Pick From Gallery"),
          ),
        ],
      ),
    );
  }
}
