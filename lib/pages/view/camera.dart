import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nutriscan_app/main.dart';
import 'package:nutriscan_app/pages/components/drawer.dart';
import 'package:tflite_v2/tflite_v2.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String output = '';
  bool isModelBusy = false;
  final Logger logger = Logger();

  @override
  void initState() {
    super.initState();
    loadCamera();
    loadModel();
  }

  loadCamera() {
    cameraController = CameraController(cameras![0], ResolutionPreset.medium);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          cameraController!.startImageStream((imageStream) {
            cameraImage = imageStream;
            runModel();
          });
        });
      }
    });
  }

  runModel() async {
    if (cameraImage != null && !isModelBusy) {
      setState(() {
        isModelBusy = true;
      });

      try {
        var resultPrediction = await Tflite.runModelOnFrame(
          bytesList: cameraImage!.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageHeight: cameraImage!.height,
          imageWidth: cameraImage!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 2,
          threshold: 0.1,
          asynch: true,
        );

        if (resultPrediction != null && resultPrediction.isNotEmpty) {
          setState(() {
            output = resultPrediction[0]["label"];
          });
        }
      } catch (e) {
        logger.e("Error running model: $e");
      } finally {
        setState(() {
          isModelBusy = false;
        });
      }
    }
  }

  loadModel() async {
    try {
      await Tflite.loadModel(
        model: "images/model_unquant.tflite",
        labels: "images/labels.txt",
      );
    } catch (e) {
      logger.e("Error loading model: $e");
    }
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
          'Camera',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: const CustomDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: !cameraController!.value.isInitialized
                  ? Container()
                  : AspectRatio(
                      aspectRatio: cameraController!.value.aspectRatio,
                      child: CameraPreview(cameraController!),
                    ),
            ),
          ),
          Text(
            output,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}
