import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'clip-board.dart';

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
    TextEditingController _controller =
        TextEditingController(text: _textFromImage);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          // _onCamera();
          await showDialog(
              context: context,
              builder: (context) {
                return Camera(
                  enableCameraChange: true,
                  orientationEnablePhoto: CameraOrientation.landscape,
                  imageMask: CameraFocus.rectangle(
                      color: Colors.black.withOpacity(0.5)),
                  onFile: (file) {
                    _sendData(file);
                    setState(() {
                      photoPath = file;
                    });
                    Navigator.pop(context);
                    _getText();
                  },
                );
              });
        },
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => ClipBoard()));
              })
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            height: 0.4.sh,
            child: Stack(
              children: [
                photoPath != null
                    ? Image.file(
                        photoPath,
                        fit: BoxFit.contain,
                      )
                    : Text("NO Photo"),
                photoPath != null
                    ? Align(
                        alignment: Alignment.center,
                        // child: FlatButton(color:Colors.white, child: Text("Send the File"),onPressed: (){_getText();},),
                      )
                    : Container(),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            // height: 0.5.sh,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Your text here",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Card(
                    child: TextFormField(
                      controller: _controller,
                      decoration:
                          InputDecoration(hintText: "your text will be here"),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future _sendData(File path) async {
    print("////////////////////////");
    await platForm.invokeMethod("GOT_FILE", path.path);
    print("///////////+++++++++++++++++++++++/////////////");

    await _getText();

    photoPath = null;
  }

  Future _getText() async {
    var value;
    value = await platForm.invokeMethod("GET_TEXT");
    setState(() {
      _textFromImage = value;
      print("///////////+++++++++++++++++++++++/////////////");

      print(value);
    });
    var doc = FirebaseFirestore.instance.collection("users").doc();
    await doc.set({
      "textToImage": value,
      "timeStamp": FieldValue.serverTimestamp(),
      "id": doc.id
    }, SetOptions(merge: true));
  }
}
