import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:funwithml/utils/common_colors.dart';
import 'package:funwithml/utils/text_style.dart';
import 'package:funwithml/view/emotion_detection/emotion_detection_view_model.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class EmotionDetectionView extends StatefulWidget {
  const EmotionDetectionView({Key? key}) : super(key: key);

  @override
  _EmotionDetectionViewState createState() => _EmotionDetectionViewState();
}

class _EmotionDetectionViewState extends State<EmotionDetectionView> {
  EmotionDetectionViewModel? mViewModel;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      mViewModel =
          Provider.of<EmotionDetectionViewModel>(context, listen: false);
      mViewModel!.loadCamera(cameras[0]);
      mViewModel!.loadModel();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mViewModel = Provider.of<EmotionDetectionViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Live Emotion Detection"),
        backgroundColor: CommonColors.primaryColor,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                child: !mViewModel!.cameraController!.value.isInitialized
                    ? Container()
                    : AspectRatio(
                        aspectRatio:
                            mViewModel!.cameraController!.value.aspectRatio,
                        child: CameraPreview(mViewModel!.cameraController!),
                      ),
              ),
            ),
            _cameraTogglesRowWidget(),
            Text(
                mViewModel!.output!.isNotEmpty
                    ? mViewModel!.output!.substring(1)
                    : "",
                style: CommonStyle.getGibsonStyle(
                    color: CommonColors.black7c, fontSize: 20))
          ],
        ),
      ),
    );
  }

  Widget _cameraTogglesRowWidget() {
    CameraDescription selectedCamera = cameras[mViewModel!.selectedCameraIdx];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;
    return Align(
      alignment: Alignment.centerLeft,
      child: FlatButton.icon(
          onPressed: mViewModel!.onSwitchCamera,
          icon: Icon(_getCameraLensIcon(lensDirection)),
          label: Text(
              "${lensDirection.toString().substring(lensDirection.toString().indexOf('.') + 1)}")),
    );
  }

  IconData _getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        return Icons.device_unknown;
    }
  }
}
