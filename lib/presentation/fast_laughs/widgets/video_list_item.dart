import 'package:flutter/material.dart';
import 'package:netflix_clone/application/fast_laughs/fast_laughs_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/colors/constants.dart';
import 'package:netflix_clone/domain/downloads/models/downloads.dart';
import 'package:video_player/video_player.dart';
import 'package:share_plus/share_plus.dart';

class VideoListitemInheritedWidget extends InheritedWidget {
  final Widget widgets;
  final Downloads movieData;

  const VideoListitemInheritedWidget(
      {required this.movieData, required this.widgets, super.key})
      : super(child: widgets);

  @override
  bool updateShouldNotify(covariant VideoListitemInheritedWidget oldWidget) {
    return oldWidget.movieData != movieData;
  }

  static VideoListitemInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VideoListitemInheritedWidget>();
  }
}

class VideoListItem extends StatelessWidget {
  final int index;
  const VideoListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final posterPath =
        VideoListitemInheritedWidget.of(context)?.movieData.posterpath;
    return Stack(
      children: [
        FastLaughVideoPlayer(
            videoUrl: videoUrls[index % videoUrls.length],
            onStateChanged: (bool) {}),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // =========left Side==========
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black.withOpacity(0.5),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.volume_mute,
                      size: 30,
                      color: kwhiteColor,
                    ),
                  ),
                ),

                // ===========Right side===========
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CircleAvatar(
                        radius: 26,
                        backgroundImage: posterPath == null
                            ? null
                            : NetworkImage('$imageAppendUrl$posterPath'),
                      ),
                    ),
                    const VideoActionsWidget(
                      icon: Icons.emoji_emotions,
                      title: "LOL",
                    ),
                    const VideoActionsWidget(
                      icon: Icons.add,
                      title: "My List",
                    ),
                    GestureDetector(
                      child: const VideoActionsWidget(
                        icon: Icons.share,
                        title: "Share",
                      ),
                      onTap: () {
                        final movieName =
                            VideoListitemInheritedWidget.of(context)
                                ?.movieData
                                .posterpath;
                        if (movieName != null) {
                          Share.share(movieName);
                        }
                      },
                    ),
                    ValueListenableBuilder(
                        valueListenable:_FastLaughVideoPlayerState.test,
                        builder: (context, value, _) {
                          return GestureDetector(
                            child: VideoActionsWidget(
                              icon: value == true
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              title: value == false ? "Play" : "pause",
                            ),
                            onTap: () async {
                              // value == true
                              if (_FastLaughVideoPlayerState
                                  .videoPlayerController.value.isPlaying) {
                                _FastLaughVideoPlayerState.videoPlayerController
                                    .pause();
                               _FastLaughVideoPlayerState.test.value = false;
                              } else {
                                _FastLaughVideoPlayerState.videoPlayerController
                                    .play();
                               _FastLaughVideoPlayerState.test.value = true;
                              }
                            },
                          );
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class VideoActionsWidget extends StatelessWidget {
  const VideoActionsWidget(
      {super.key, required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Icon(
            icon,
            color: kwhiteColor,
            size: 26,
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}



class FastLaughVideoPlayer extends StatefulWidget {
  const FastLaughVideoPlayer(
      {super.key, required this.videoUrl, required this.onStateChanged});
  final String videoUrl;
  final void Function(bool isPlaying) onStateChanged;
  @override
  State<FastLaughVideoPlayer> createState() => _FastLaughVideoPlayerState();
}

class _FastLaughVideoPlayerState extends State<FastLaughVideoPlayer> {
  static late VideoPlayerController videoPlayerController;

  static ValueNotifier test = ValueNotifier(true);
  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    videoPlayerController.initialize().then((value) {
      setState(() {
        videoPlayerController.play();
      });
    });
    super.initState();
    test.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: VideoPlayer(videoPlayerController),
            )
          : const Center(
              child: CircularProgressIndicator(
                strokeWidth: 5,
              ),
            ),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
    test.value = false;
  }
}
