import 'package:copy_paste/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
void main(){
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

