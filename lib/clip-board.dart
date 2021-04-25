import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ClipBoard extends StatefulWidget {
  @override
  _ClipBoardState createState() => _ClipBoardState();
}

class _ClipBoardState extends State<ClipBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc().snapshots(),
        builder: (context, snap){
          if(snap.hasData){
            return Text(snap.data.data()['textToImage']);
          }else{
            return Center(child: Text("No text"));
          }
        },
      ),
    );
  }
}
