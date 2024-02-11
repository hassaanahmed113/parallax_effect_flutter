import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallax_effect/view/home/home_controller.dart';
import 'package:transparent_image/transparent_image.dart';
import 'dart:math' as math;

class CarouselImages extends StatefulWidget {
  ///List with assets path or url. Required
  final List<String> listImages;

  ///OnTap function. Index = index of active page. Optional
  final Function(int index)? onTap;

  ///Height of whole carousel. Required
  final double height;

  ///Possibility to cached images from network. Optional
  final bool cachedNetworkImage;

  ///Height of nearby images. From 0.0 to 1.0. Optional
  final double scaleFactor;

  ///Border radius of image. Optional
  final double? borderRadius;

  ///Vertical alignment of nearby images. Optional
  final Alignment? verticalAlignment;

  ///ViewportFraction. From 0.5 to 1.0. Optional
  final double viewportFraction;

  const CarouselImages({
    Key? key,
    required this.listImages,
    required this.height,
    this.onTap,
    this.cachedNetworkImage = false,
    this.scaleFactor = 1.0,
    this.borderRadius,
    this.verticalAlignment,
    this.viewportFraction = 0.9,
  })  : assert(scaleFactor > 0.0),
        assert(scaleFactor <= 1.0),
        super(key: key);

  @override
  _CarouselImagesState createState() => _CarouselImagesState();
}

class _CarouselImagesState extends State<CarouselImages> {
  late PageController _pageController;
  double _currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
        viewportFraction: widget.viewportFraction.clamp(0.5, 1.0));
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  final homcontroller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: widget.height,
      child: Material(
        color: Colors.transparent,
        child: AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            return PageView.builder(
              physics: const BouncingScrollPhysics(),
              controller: _pageController,
              itemCount: widget.listImages.length,
              onPageChanged: (value) {
                homcontroller.updateIndex(value);
              },
              itemBuilder: (context, position) {
                double value = (1 -
                        ((_currentPageValue - position).abs() *
                            (1 - widget.scaleFactor)))
                    .clamp(0.0, 1.0);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                          height: Curves.ease.transform(value) * widget.height,
                          child: child),
                      Align(
                          alignment: widget.verticalAlignment != null
                              ? widget.verticalAlignment!
                              : Alignment.center,
                          child: SizedBox(
                            height:
                                Curves.ease.transform(value) * widget.height,
                            child: ClipRRect(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              borderRadius: BorderRadius.circular(
                                  widget.borderRadius != null
                                      ? widget.borderRadius!
                                      : 16.0),
                              child: Container(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Transform.translate(
                                    offset: Offset(
                                        (_currentPageValue - position) *
                                            width /
                                            4 *
                                            math.pow(
                                                widget.viewportFraction, 3),
                                        0),
                                    child: widget.listImages[position]
                                            .startsWith('http')
                                        ? widget.cachedNetworkImage
                                            ? CachedNetworkImage(
                                                imageUrl:
                                                    widget.listImages[position],
                                                imageBuilder:
                                                    (context, image) =>
                                                        GestureDetector(
                                                  onTap: () => widget.onTap !=
                                                          null
                                                      ? widget.onTap!(position)
                                                      : () {},
                                                  child: Image(
                                                      image: image,
                                                      fit: BoxFit.fitHeight),
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () => widget.onTap !=
                                                        null
                                                    ? widget.onTap!(position)
                                                    : () {},
                                                child:
                                                    FadeInImage.memoryNetwork(
                                                  placeholder:
                                                      kTransparentImage,
                                                  image: widget
                                                      .listImages[position],
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              )
                                        : GestureDetector(
                                            onTap: () => widget.onTap != null
                                                ? widget.onTap!(position)
                                                : () {},
                                            child: Image.asset(
                                              widget.listImages[position],
                                              fit: BoxFit.fitHeight,
                                            ),
                                          )),
                              ),
                            ),
                          ))
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
