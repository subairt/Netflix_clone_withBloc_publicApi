import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/presentation/downloads/widgets/buttos_widget.dart';

class Section3 extends StatelessWidget {
  const Section3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        SizedBox(
          width: double.infinity,
          child: ButtonWidget(
            btnBckgrdBttn: kblueColorbutton,
            title: "Setup",
          ),
        ),
        ButtonWidget(
          btnBckgrdBttn: kwhiteColor,
          title: "See what you can download",
        ),
      ],
    );
  }
}
