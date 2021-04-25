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
        stream: FirebaseFirestore.instance.collection('users').orderBy('timeStamp', descending: true).snapshots(),
        builder: (context, snap){
          if(snap.hasData&&snap.data.docs.length != null ){
            return ListView.builder(
              itemCount: snap.data.docs.length,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("${index+1}. "),

                    Expanded(
                      child: Card(
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              child: Text(snap.data.docs[index]['textToImage'],textAlign: TextAlign.justify,)),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
          }else{
            return Center(child: Text("No text"));
          }
        },
      ),
    );
  }
}
