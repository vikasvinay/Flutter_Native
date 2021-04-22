import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera_camera/camera_camera.dart';
class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  static const platForm = const MethodChannel("demo.copy_paste.com");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Camera(),
      ),
    );
  }
  Future _onCamera()async{
    await platForm.invokeMethod("ON_CAMERA");
  }
}
