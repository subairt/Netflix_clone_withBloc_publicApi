import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.cast,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          color: Colors.blue,
          width: 30,
          height: 30,
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
