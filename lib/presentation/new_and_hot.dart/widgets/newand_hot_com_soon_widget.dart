import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/colors/constants.dart';
import 'package:netflix_clone/presentation/widgets/text_icon_buttos.dart';
import 'package:netflix_clone/presentation/widgets/vidoe_widget.dart';

class NewAndHotComSoonWidget extends StatelessWidget {
  const NewAndHotComSoonWidget({
    super.key,
    required this.size,
    required this.id,
    required this.mnthText,
    required this.dayText,
    required this.movieName,
    required this.posterPath,
    required this.description,
  });

  final Size size;
  final String id;
  final String mnthText;
  final String dayText;
  final String movieName;
  final String posterPath;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          height: size.height * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                mnthText,
                style: styleMnth,
              ),
              Text(
                dayText,
                style: styleNumber,
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.5,
          width: size.width - 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               VideosWidget(vidoeUrl: posterPath),
              Row(
                children:  [
                  Expanded(
                    child: Text(
                      movieName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const TextIconButton(
                    icon: Icons.notifications_sharp,
                    title: "Remind me",
                    iconsize: 20,
                    textsize: 16,
                  ),
                  const TextIconButton(
                    icon: Icons.info,
                    title: "Info",
                    iconsize: 20,
                    textsize: 20,
                  )
                ],
              ),
              khight,
               Text(
                "Coming On $dayText $mnthText",
                style: style,
              ),
              khight,
               Text(
                movieName,
                overflow: TextOverflow.fade,
                maxLines: 1,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kwhiteColor),
              ),
              khight,
               Text(
                description,
                overflow: TextOverflow.fade,
                maxLines: 3,
                style: const TextStyle(color: Colors.grey,fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
