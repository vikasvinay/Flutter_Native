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
    TextEditingController _controller = TextEditingController(text: _textFromImage);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          // _onCamera();
<<<<<<< HEAD
=======
        await  showDialog(context: context,
            builder: (context){
            return Camera(
              enableCameraChange: true,
              orientationEnablePhoto: CameraOrientation.landscape,
              imageMask: CameraFocus.rectangle(color: Colors.black.withOpacity(0.5)),
              onFile: (file){

                _sendData(file);
                setState(() {
                  photoPath = file;
                });
                Navigator.pop(context);
                _getText();
              },
            );
            }
          );
>>>>>>> 32d2025568186d272df2e2b87b078255a2c13faa

          photoPath = await showDialog(
              context: context,
              builder: (context) {
                return Camera(
                  // onFile: (File file) {
                  //   sendData(file);

                  // },
                  enableCameraChange: true,
                  orientationEnablePhoto: CameraOrientation.landscape,
                  imageMask: CameraFocus.rectangle(
                      color: Colors.black.withOpacity(0.5)),
                );
              });
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
<<<<<<< HEAD
                photoPath != null
                    ? Image.file(
                        photoPath,
                        fit: BoxFit.contain,
                      )
                    : Text("NO Photo"),
                photoPath != null
                    ? Align(
                        alignment: Alignment.center,
                        child: FlatButton(
                          color: Colors.white,
                          child: Text("Send the File"),
                          onPressed: () {
                            _sendData();
                          },
                        ),
                      )
                    : Container(),
=======

                photoPath!= null ? Image.file(photoPath, fit: BoxFit.contain,): Text("NO Photo"),
                photoPath!= null ?Align(
                  alignment: Alignment.center,
                  // child: FlatButton(color:Colors.white, child: Text("Send the File"),onPressed: (){_getText();},),
                ):Container(),
>>>>>>> 32d2025568186d272df2e2b87b078255a2c13faa
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            // height: 0.5.sh,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
<<<<<<< HEAD
                Text(
                  "Your text here",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
                Card(
                  child: Text(_textFromImage),
=======
                Text("Your text here", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Card(
                    child: TextFormField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "your text will be here"
                      ),
                    ),
                  ),
>>>>>>> 32d2025568186d272df2e2b87b078255a2c13faa
                )
              ],
            ),
          )
        ],
      ),
    );
  }
<<<<<<< HEAD

  Future _sendData() async {
    print(photoPath.path);
    print("//////////////sai//////////");
    await platForm.invokeMethod("GOT_FILE", photoPath.path);
    photoPath = null;
=======
  Future _sendData(File path)async{
    print("////////////////////////");
    await platForm.invokeMethod("GOT_FILE", path.path);
    print("///////////+++++++++++++++++++++++/////////////");

>>>>>>> 32d2025568186d272df2e2b87b078255a2c13faa
    await _getText();

    photoPath = null;
  }
<<<<<<< HEAD

  Future sendData(File photo) async {
    print(photo.path);
    print("//////////////sai//////////");
    await platForm.invokeMethod("GOT_FILE", photo.path);
    photo = null;
    await _getText();
  }

  Future _getText() async {
    await platForm.invokeMethod("GET_TEXT").then((value) {
      setState(() {
        _textFromImage = value;
        print(value);
      });
=======
  Future _getText()async{
    var value;
    value = await platForm.invokeMethod("GET_TEXT");
    setState(() {
      _textFromImage = value;
      print("///////////+++++++++++++++++++++++/////////////");

      print(value);
>>>>>>> 32d2025568186d272df2e2b87b078255a2c13faa
    });
  }
}
