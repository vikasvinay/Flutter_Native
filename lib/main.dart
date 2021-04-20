import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platForm = const MethodChannel("demo.message.com");
  var gotList = [];
  TextEditingController text = TextEditingController();
  @override
  void initState() {
    _getMessage();
    super.initState();
  }

  @override
  void dispose() {
    text.dispose();
    super.dispose();
  }
  var redraw;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TextField(
                controller: text,
                decoration: InputDecoration(hintText: "Type here..."),
              ),
            ),
            FlatButton.icon(
                onPressed: () {
                  if(text.text.length > 2){
                    _sendMessage();
                    _getMessage();
                    text.clear();
                  }

                },
                icon: Icon(Icons.save),
                label: Text("Save")),
            SizedBox(height: 100,),
            Center(
                child: Text(
                  'List',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              child: ListView.builder(
                key: ValueKey<Object>(redraw),
                  shrinkWrap: true,
                  itemCount: gotList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        title: Text("${gotList[index]}"),
                        leading: Text("${index+1}"),
                        trailing: IconButton(icon: Icon(Icons.delete, color: Colors.red,),onPressed: (){
                          _deleteMessage(index);
                        },),
                      )
                    );
                  }),
            )
          ],
        ),

      )
    );
  }

  Future _getMessage() async {

    List<dynamic> message;
    print("pressed");
    message = await platForm.invokeMethod("getMethod");
    print(message);
    print("llllllllllllllll");
    try {
      gotList = await platForm.invokeMethod("getMethod");
      print(message);
      setState(() {
        gotList = [];
        gotList = message??[];
        redraw = Object();
      });
    } catch (e) {
      print("ERROR");
      print(e);
    }
  }
  Future _deleteMessage(int index)async{
    await platForm.invokeMethod("deleteMessage", index.toString());
    await _getMessage();
  }
  Future _sendMessage() async {
    await platForm.invokeMethod("sendMessage",text.text.trim());
    print("uuuuuuuuuuuuuuuuuuu");
    debugPrint(await platForm.invokeMethod("sendMessage"));
    await _getMessage();
  }
}
