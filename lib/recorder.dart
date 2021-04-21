import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class Recorder extends StatefulWidget {
  @override
  _RecorderState createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  static const platForm = const MethodChannel("demo.message.com");
  TextEditingController inputFileName = TextEditingController();
  bool isMicOn = false;
  List fileName = <String>[];
  @override
  void initState() {
    // _micOFF();
    super.initState();
  }
  @override
  void dispose() {
    inputFileName.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 10,),
              CircleAvatar(
                radius: 80,
                backgroundColor: isMicOn?Colors.red: Colors.lightBlue,
                child: GestureDetector(
                    onTap: (){
                  if(!isMicOn){
                    _micON();
                    setState(() {
                      isMicOn = true;
                    });
                  }else{
                    _micOFF();
                    setState(() {

                      isMicOn = false;
                    });

                  }

                }, child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(!isMicOn ? Icons.mic: Icons.pause_circle_filled, size: 65,color: Colors.white,),
                    SizedBox(height: 10,),
                    Text(!isMicOn ? "Record": "Stop", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),)
                  ],
                )),
              ),
              // Container(
              //   padding: const EdgeInsets.symmetric (horizontal: 30),
              //   child: Form(
              //   autovalidateMode: AutovalidateMode.always,
              //     child: TextFormField(
              //       controller: inputFileName,
              //       validator: (v){
              //         if(v.length< 2){
              //           return "Provide file name\nmin length > 2";
              //         }else{
              //           return null;
              //         }
              //       },
              //
              //       decoration: InputDecoration(
              //
              //           hintText: "Give File Name here"
              //       ),
              //     ),
              //   )
              // ),
              SizedBox(height: 50,),
              Text("Your Recordings: "),
              SizedBox(height: 20,),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: ListView.builder(
                  itemCount: fileName.length,
                  shrinkWrap: true,
                    itemBuilder: (context, index){
                    if(fileName.length > 0){
                      return GestureDetector(
                        onTap: (){
                          _play(index);
                        },
                          child: Card(

                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text("${index+1}. ${fileName[index]}"),
                              )));

                    }else{
                      return Center(child: Text("No Files"),);
                    }
                }),
              )

            ],
          ),
        ),
      ),
    );
  }
  Future _micON()async{
    await platForm.invokeMethod("MIC_ON");
  }
  Future _micOFF()async{
    var file;
    await platForm.invokeMethod("MIC_OFF");
    file = await platForm.invokeMethod("MIC_OFF");
    setState(() {
      fileName = file??[];
    });

  }
  Future _play(int index)async{
  await platForm.invokeMethod("PLAY", "$index");
  }
  Future _stop()async{

  }
}
