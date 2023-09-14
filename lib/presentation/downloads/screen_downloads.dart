import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/constants.dart';
import 'package:netflix_clone/presentation/downloads/widgets/downloads_secrtion_two.dart';
import 'package:netflix_clone/presentation/downloads/widgets/downloads_section_3.dart';
import 'package:netflix_clone/presentation/downloads/widgets/smart_downloads.dart';
import 'package:netflix_clone/presentation/widgets/appbar_widget.dart';

class ScreenDownloads extends StatelessWidget {
  ScreenDownloads({super.key});

  final widgetList = [
    const SmartDownloads(),
    const Section2(),
    const Section3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(53.0),
        child: AppbarWidget(title: "Downloads"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return widgetList[index];
          },
          separatorBuilder: (context, index) {
            return khight20;
          },
          itemCount: widgetList.length,
        ),
      ),
    );
  }
}
