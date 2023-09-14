import 'package:flutter/material.dart';

class SearchTextTitle extends StatelessWidget {
  const SearchTextTitle({
    super.key,
    required this.titles,
  });

  final String titles;

  @override
  Widget build(BuildContext context) {
    return Text(
      titles,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
