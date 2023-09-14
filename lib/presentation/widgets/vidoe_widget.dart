import 'package:flutter/material.dart';

class VideosWidget extends StatelessWidget {
  const VideosWidget({
    super.key,
    required this.vidoeUrl,
  });

  final String vidoeUrl;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.25,
      child: Image.network(
        vidoeUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return const Center(
              child: CircularProgressIndicator(
                
              ),
            );
          }
        },
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.wifi,
            color: Colors.white,
          );
        },
      ),
    );
  }
}
