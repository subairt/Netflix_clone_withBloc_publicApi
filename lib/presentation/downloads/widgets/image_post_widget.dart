import 'dart:math';

import 'package:flutter/material.dart';

class ImagePostWidget extends StatelessWidget {
  const ImagePostWidget(
      {super.key,
      required this.size,
      required this.images,
      required this.angle,
      this.margin,
      this.width = 0.38,
      this.hight = 0.54});

  final Size size;
  final String images;
  final double angle;
  final dynamic margin;
  final double width;
  final double hight;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle * pi / 180,
      child: Container(
        margin: margin,
        width: size.width * width,
        height: size.width * hight,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(images),
          ),
        ),
      ),
    );
  }
}
