import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';

class TextIconButton extends StatelessWidget {
  const TextIconButton({
    super.key,
    required this.title,
    required this.icon,
    required this.iconsize,
    required this.textsize,
  });

  final String title;
  final IconData icon;
  final double iconsize;
  final double textsize;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Column(
        children: [
          Icon(
            icon,
            color: kwhiteColor,
            size: iconsize,
          ),
          Text(
            title,
            style: TextStyle(color: kwhiteColor, fontSize: textsize),
          ),
        ],
      ),
    );
  }
}
