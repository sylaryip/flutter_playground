import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ScreenUtilInit(
            designSize: const Size(375.0, 812.0),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (BuildContext context, Widget? child) {
              return const Home();
            }));
  }
}
