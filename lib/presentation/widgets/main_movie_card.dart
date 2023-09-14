import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/constants.dart';

class MainMovieCard extends StatelessWidget {
  final String imageUrl;
  const MainMovieCard({
    super.key, required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
      width: 150,
      decoration: BoxDecoration(
        borderRadius: kRadius10,
        image:  DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            imageUrl,
          ),
        ),
      ),
    );
  }
}
