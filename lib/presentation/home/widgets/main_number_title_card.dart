import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/constants.dart';

class MainNumberTitleCard extends StatelessWidget {
  const MainNumberTitleCard({super.key, required this.numbers, required this.imageurl});

  final int numbers;
  final String imageurl;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 40,
            ),
            Container(
              margin:
                  const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
              width: 150,
              decoration: BoxDecoration(
                borderRadius: kRadius10,
                image:  DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    imageurl,
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 10,
          left: 15,
          child: BorderedText(
            strokeWidth: 5.0,
            strokeColor: Colors.white,
            child: Text(
              '$numbers',
              style: const TextStyle(
                fontSize: 120,
                color: Colors.black,
                decoration: TextDecoration.none,
                decorationColor: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
