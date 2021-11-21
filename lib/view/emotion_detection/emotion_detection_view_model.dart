import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:funwithml/utils/common_utils.dart';
import 'package:tflite/tflite.dart';

import '../../main.dart';

class EmotionDetectionViewModel with ChangeNotifier {
  CameraImage? cameraImage;
  CameraController? cameraController;
  String? output = "";
  int selectedCameraIdx = 0;

  loadCamera(CameraDescription cameraDescription) {
    cameraController =
        CameraController(cameraDescription, ResolutionPreset.medium);
    cameraController!.initialize().then((value) {
      cameraController!.startImageStream((image) {
        cameraImage = image;
        notifyListeners();
        runModel();
      });
    });
    notifyListeners();
  }

  void runModel() async {
    printf("fdkjfkd=>" + cameraImage!.height.toString());
    if (cameraImage != null) {
      var prediction = await Tflite.runModelOnFrame(
          bytesList: cameraImage!.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageHeight: cameraImage!.height,
          imageWidth: cameraImage!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 3,
          threshold: 0.1,
          asynch: true);

      prediction!.forEach((element) {
        output = element['label'];
      });

      print("output" + output.toString());

      notifyListeners();
    }
  }

  loadModel() async {
    String? loadModel = await Tflite.loadModel(
        model: "assets/tflite/model.tflite",
        labels: "assets/tflite/labels.txt");

    print("asdfh=>" + loadModel.toString());
    notifyListeners();
  }

  void onSwitchCamera() {
    selectedCameraIdx =
        selectedCameraIdx < cameras.length - 1 ? selectedCameraIdx + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIdx];
    loadCamera(selectedCamera);
    notifyListeners();
    //_initCameraController(selectedCamera);
  }
}
