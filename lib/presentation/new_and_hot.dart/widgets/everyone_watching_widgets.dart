import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/colors/constants.dart';
import 'package:netflix_clone/presentation/widgets/text_icon_buttos.dart';
import 'package:netflix_clone/presentation/widgets/vidoe_widget.dart';

class EveryOneWatchinWdget extends StatelessWidget {
  const EveryOneWatchinWdget({
    super.key,
    required this.movieName,
    required this.posterPath,
    required this.description,
  });
  final String movieName;
  final String posterPath;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          movieName,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: kwhiteColor),
        ),
        khight,
         Text(description,overflow: TextOverflow.ellipsis,
         maxLines: 4,
          style: const TextStyle(color: Colors.grey,fontSize: 15),
        ),
        khight,
         VideosWidget(vidoeUrl: posterPath),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            TextIconButton(
              icon: Icons.share,
              iconsize: 25,
              title: "Share",
              textsize: 20,
            ),
            TextIconButton(
              icon: Icons.add,
              iconsize: 25,
              title: "Share",
              textsize: 20,
            ),
            TextIconButton(
              icon: Icons.play_arrow,
              iconsize: 25,
              title: "Share",
              textsize: 20,
            ),
          ],
        ),
      ],
    );
  }
}
