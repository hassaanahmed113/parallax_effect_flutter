import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallax_effect/view/home/home_controller.dart';
import 'package:parallax_effect/view/home/homepage.dart';

void main() {
  runApp(const MyApp());
  Get.put(HomeController(), permanent: true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
