import 'package:flutter/material.dart';

ValueNotifier<int> indexchangeNotifier = ValueNotifier(0);

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexchangeNotifier,
      builder: (context, newindex, _) {
        return BottomNavigationBar(
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          currentIndex: newindex,
          onTap: (value) {
            indexchangeNotifier.value = value;
          },
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.collections), label: "New & Hot"),
            BottomNavigationBarItem(
                icon: Icon(Icons.emoji_emotions), label: "Fast Laughs"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.arrow_circle_down), label: "Download"),
          ],
        );
      },
    );
  }
}
