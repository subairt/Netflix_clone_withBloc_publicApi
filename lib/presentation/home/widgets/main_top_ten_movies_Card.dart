import 'package:flutter/material.dart';
import 'package:netflix_clone/presentation/home/widgets/main_number_title_card.dart';
import 'package:netflix_clone/presentation/widgets/main_title.dart';

class MainTopTenMoviesCard extends StatelessWidget {
  const MainTopTenMoviesCard({
    super.key, required this.posterlist,
  });
  final List<String> posterlist;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MainTitles(
          title: "Top 10 TV Shows In India Today",
        ),
        LimitedBox(
          maxHeight: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              posterlist.length,
              (index) => MainNumberTitleCard(numbers: index + 1,imageurl: posterlist[index]),
            ),
          ),
        ),
      ],
    );
  }
}
