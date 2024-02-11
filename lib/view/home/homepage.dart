import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parallax_effect/view/carosel_image.dart';
import 'package:parallax_effect/view/home/home_controller.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});
  List<String> wallList = [
    'assets/images/song1.PNG',
    'assets/images/wall2.PNG',
    'assets/images/wall3.PNG',
    'assets/images/wall4.PNG',
    'assets/images/wall5.PNG',
  ];
  List<String> wallname = [
    'La Diabla',
    'Cruel Summer',
    'Lose Control',
    'Starboy',
    'Que Onda',
  ];
  List<String> wallartist = [
    'Xavi',
    'Taylor Swift',
    'Teddy Swims',
    'Daft PunkThe Weeknd',
    'Calle 24, Chino Pacas, Fuerza Regida',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Stack(
        children: [
          GetBuilder<HomeController>(
            builder: (controller) {
              return ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.asset(
                    wallList[controller.index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(0.5),
          ),
          Column(
            children: <Widget>[
              const SizedBox(height: 150),
              CarouselImages(
                scaleFactor: 0.7,
                listImages: wallList,
                height: 350.0,
                viewportFraction: 1,
                borderRadius: 12.0,
                cachedNetworkImage: true,
                verticalAlignment: Alignment.bottomCenter,
              )
            ],
          ),
          Positioned(
              top: 520,
              bottom: 0,
              left: 10,
              right: 10,
              child: GetBuilder<HomeController>(
                builder: (controller) {
                  return Text(
                    wallname[controller.index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: GoogleFonts.openSans().fontFamily,
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  );
                },
              )),
          Positioned(
              top: 560,
              bottom: 0,
              left: 10,
              right: 10,
              child: GetBuilder<HomeController>(
                builder: (controller) {
                  return Text(
                    wallartist[controller.index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: GoogleFonts.openSans().fontFamily,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  );
                },
              )),
          Positioned(
              top: 500,
              bottom: 0,
              left: 10,
              right: 10,
              child: Image.asset('assets/images/music.png'))
        ],
      ),
    );
  }
}
