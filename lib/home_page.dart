

import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platForm = const MethodChannel("demo.copy_paste.com");
  File photoPath;
  String _textFromImage = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: ()async{
          // _onCamera();
        photoPath =  await  showDialog(context: context,
            builder: (context){
            return Camera(
              enableCameraChange: true,
              orientationEnablePhoto: CameraOrientation.landscape,
              imageMask: CameraFocus.rectangle(color: Colors.black.withOpacity(0.5)),
            );
            }
          );

        },
      ),
      appBar: AppBar(), 

      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            height: 0.4.sh,
            child: Stack(
              children: [

                photoPath!= null ? Image.file(photoPath, fit: BoxFit.contain,): Text("NO Photo"),
                photoPath!= null ?Align(
                  alignment: Alignment.center,
                  child: FlatButton(color:Colors.white, child: Text("Send the File"),onPressed: (){_sendData();},),
                ):Container(),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            // height: 0.5.sh,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Your text here", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),),
                Card(
                  child: Text(_textFromImage),
                )
              ],
            ),
          )
        ],
      ),

    );
  }
  Future _sendData()async{
    print(photoPath.path);
    print("////////////////////////");
    await platForm.invokeMethod("GOT_FILE", photoPath.path);
    photoPath = null;
    await _getText();
  }
  Future _getText()async{
    await platForm.invokeMethod("GET_TEXT").then((value) {
      setState(() {
        _textFromImage = value;
        print(value);
      });
    });
  }
}
