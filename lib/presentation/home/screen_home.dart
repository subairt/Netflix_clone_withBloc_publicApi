import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/home/home_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/colors/constants.dart';
import 'package:netflix_clone/presentation/home/widgets/main_title_with_card.dart';
import 'package:netflix_clone/presentation/home/widgets/main_top_ten_movies_Card.dart';
import 'package:netflix_clone/presentation/widgets/appbar_widget.dart';
import 'package:netflix_clone/presentation/widgets/text_icon_buttos.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    ValueNotifier scrollNotifier = ValueNotifier(true);
    final ksizeWidth = MediaQuery.of(context).size.width;
    final ksizeHight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              } else if (state.hasError) {
                return const Center(
                  child: Text(
                    "Error while getting data",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              // relesed past year
              final releasePastYear = state.pastYearMovielist.map((m) {
                return '$imageAppendUrl${m.posterPath}';
              }).toList();
              // Trending
              final trending = state.trendingMovieList.map((m) {
                return '$imageAppendUrl${m.posterPath}';
              }).toList();
              // Tense Dramas
              final tenseDrams = state.tenceDramasMovieList.map((m) {
                return '$imageAppendUrl${m.posterPath}';
              }).toList();
              // south indian movies
              final southIndian = state.southIndianMovieList.map((m) {
                return '$imageAppendUrl${m.posterPath}';
              }).toList();
              // Top 10 Tv shows
              final toptenMovies = state.trendingTvList.map(
                (m) {
                  return '$imageAppendUrl${m.posterPath}';
                },
              ).toList();
              toptenMovies.shuffle();
              southIndian.shuffle();
              tenseDrams.shuffle();
              trending.shuffle();

              return ListView(
                children: [
                  MainBannerWidget(
                      ksizeWidth: ksizeWidth, ksizeHight: ksizeHight),
                  if (releasePastYear.length >= 10)
                    MainTitleWithCards(
                        posterList: releasePastYear.sublist(0, 10),
                        titles: "Released In the Past Year"),
                  if (trending.length >= 10)
                    MainTitleWithCards(
                      titles: "Trending Now",
                      posterList: trending.sublist(0, 10),
                    ),
                  if (toptenMovies.length >= 10)
                    MainTopTenMoviesCard(
                      posterlist: toptenMovies.sublist(0, 10),
                    ),
                  if (tenseDrams.length >= 10)
                    MainTitleWithCards(
                      titles: "Tense Dramas",
                      posterList: tenseDrams.sublist(0, 10),
                    ),
                  if (southIndian.length >= 10)
                    MainTitleWithCards(
                      titles: "South Indian Cinema",
                      posterList: southIndian.sublist(0, 10),
                    ),
                ],
              );
            },
          ),
          ValueListenableBuilder(
            valueListenable: scrollNotifier,
            builder: (context, value, _) {
              return NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  final ScrollDirection direction = notification.direction;
                  if (direction == ScrollDirection.reverse) {
                    scrollNotifier.value = false;
                  } else if (direction == ScrollDirection.forward) {
                    scrollNotifier.value = true;
                  }
                  return true;
                },
                child: Stack(
                  children: [
                    scrollNotifier.value == true
                        ? Column(
                            children: [
                              const AppbarWidget(
                                title: 'Netflix',
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Text(
                                    "TV Shows",
                                    style: style,
                                  ),
                                  Text("Movies", style: style),
                                  Text(
                                    "Catagories",
                                    style: style,
                                  ),
                                ],
                              )
                            ],
                          )
                        : khight
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MainBannerWidget extends StatelessWidget {
  const MainBannerWidget({
    super.key,
    required this.ksizeWidth,
    required this.ksizeHight,
  });

  final double ksizeWidth;
  final double ksizeHight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/netflix.jpg"),
            ),
          ),
          width: ksizeWidth,
          height: ksizeHight * 0.75,
          // height: 600,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // ===========Mylistbutton=============
              const TextIconButton(
                  icon: Icons.add,
                  title: "My List",
                  iconsize: 25,
                  textsize: 20),
              // ================playButton position================
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kwhiteColor),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.play_arrow,
                      color: Colors.black,
                      size: 25,
                    ),
                    Text(
                      "Play",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
              ),
              const TextIconButton(
                  icon: Icons.info_outline,
                  title: "Info",
                  iconsize: 25,
                  textsize: 20),
            ],
          ),
        ),
      ],
    );
  }
}
