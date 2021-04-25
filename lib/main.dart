import 'package:copy_paste/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,

      home: MainPage(),
    )
  );
}
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(

        builder: () => HomePage());
  }
}

