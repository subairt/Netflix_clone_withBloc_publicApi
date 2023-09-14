import 'package:flutter/material.dart';
import 'package:netflix_clone/presentation/widgets/main_movie_card.dart';
import 'package:netflix_clone/presentation/widgets/main_title.dart';

class MainTitleWithCards extends StatelessWidget {
  const MainTitleWithCards({
    super.key,
    required this.titles, required this.posterList,
  });
  final String titles;
  final List<String> posterList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitles(
          title: titles,
        ),
        LimitedBox(
          maxHeight: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              posterList.length,
              (index) => MainMovieCard(imageUrl: posterList[index],),
            ),
          ),
        ),
      ],
    );
  }
}
