import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_v2/tflite_v2.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late File _imageFile;
  final ImagePicker _imagePicker = ImagePicker();
  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _loadTfliteModel();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    await _cameraController.initialize();
  }

  Future<void> _loadTfliteModel() async {
    await Tflite.loadModel(
      model:
          'assets/images/tflite/model.tflite', // Replace with your model file
      labels:
          'assets/images/tflite/labels.txt', // Replace with your labels file
    );
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      _processImage();
    }
  }

  Future<void> _getImageFromCamera() async {
    XFile? imageFile = await _imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _imageFile = File(imageFile!.path);
    });

    _processImage();
  }

  Future<void> _processImage() async {
    List? recognitions = await Tflite.runModelOnImage(
      path: _imageFile.path,
    );

    // Process the recognition results
    String result = "No food detected.";

    if (recognitions != null && recognitions.isNotEmpty) {
      // Customize the result based on your model's output
      result = "Food detected: ${recognitions[0]['label']}";

      // You can also use the confidence score if needed:
      // double confidence = recognitions[0]['confidence'];
    }

    // Display the result in an alert dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Food Recognition Result'),
          content: Text(result),
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

  @override
  void dispose() {
    _cameraController.dispose();
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Recognition App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _getImageFromGallery,
              child: const Text('Pick Image from Gallery'),
            ),
            ElevatedButton(
              onPressed: () {
                // ignore: unnecessary_null_comparison
                _cameraController != null
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CameraScreen(
                            cameraController: _cameraController,
                            onCapture: _processImage,
                          ),
                        ),
                      )
                    : null;
              },
              child: const Text('Capture Image from Camera'),
            ),
          ],
        ),
      ),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final CameraController cameraController;
  final Function onCapture;

  const CameraScreen({
    super.key,
    required this.cameraController,
    required this.onCapture,
  });

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Screen'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: CameraPreview(widget.cameraController),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              widget.onCapture();
            },
            child: const Text('Capture Image'),
          ),
        ],
      ),
    );
  }
}
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tflite_v2/tflite_v2.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   bool _isLoading = true;
//   File _image = File("");
//   final List _output = [];
//   final picker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//     loadModel().then((value) {
//       setState(() {});
//     });
//   }

//   detectImage(File image) async {
//     var output = await Tflite.runModelOnImage(
//       path: image.path,
//       numResults: 2,
//       threshold: 0.6,
//       imageMean: 127.5,
//       imageStd: 127.5,
//     );
//     setState(() {
//       _output.add(output);
//       _isLoading = false;
//     });
//     output?.clear();
//   }

//   loadModel() async {
//     await Tflite.loadModel(
//       model: 'assets/tflite/model.tflite',
//       labels: 'assets/tflite/labels.txt',
//     );
//   }

//   @override
//   void dispose() {
//     Tflite.close();
//     super.dispose();
//   }

//   pickImage() async {
//     var image = await picker.pickImage(source: ImageSource.camera);
//     if (image == null) return null;

//     setState(() {
//       _image = File(image.path);
//     });

//     detectImage(_image);
//   }

//   pickGalleryImage() async {
//     var image = await picker.pickImage(source: ImageSource.gallery);
//     if (image == null) return null;

//     setState(() {
//       _image = File(image.path);
//     });

//     detectImage(_image);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.grey[400],
//         appBar: AppBar(
//           title: const Text('Food Scanner'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ElevatedButton(
//                 onPressed: pickGalleryImage,
//                 child: const Text('Pick from Gallery'),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: pickImage,
//                 child: const Text('Capture from Camera'),
//               ),
//               const SizedBox(height: 20),
//               _isLoading
//                   ? const CircularProgressIndicator()
//                   : _output.isNotEmpty
//                       ? Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               'Scan Results:',
//                               style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 10),
//                             Text('Food: ${_output[0]['label']}'),
//                             Text(
//                                 'Confidence: ${(_output[0]['confidence'] * 100).toStringAsFixed(2)}%'),
//                           ],
//                         )
//                       : Container(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
