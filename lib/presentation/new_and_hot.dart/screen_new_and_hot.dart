import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:intl/intl.dart';
import 'package:netflix_clone/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/colors/constants.dart';
import 'package:netflix_clone/presentation/new_and_hot.dart/widgets/everyone_watching_widgets.dart';
import 'package:netflix_clone/presentation/new_and_hot.dart/widgets/newand_hot_com_soon_widget.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "New & Hot",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          actions: [
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
          bottom: TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.black,
            labelStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            indicator: BoxDecoration(
              borderRadius: kRadius30,
              color: kwhiteColor,
            ),
            tabs: const [
              Tab(
                text: ("🍿 Coming Soon"),
              ),
              Tab(
                text: ("👀 Everyone's Watching"),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            NewandHotComingSoonWidget(
              key: Key("coming_soon_list"),
            ),
            EveryOneWatching(key: Key("everyone_watching"),)
          ],
        ),
      ),
    );
  }
}

class NewandHotComingSoonWidget extends StatelessWidget {
  const NewandHotComingSoonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        BlocProvider.of<HotAndNewBloc>(context).add(
          const loadDateinComingSoon(),
        );
      },
    );
    final size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async{
        BlocProvider.of<HotAndNewBloc>(context).add(
          const loadDateinComingSoon(),
        );
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else if (state.commingSoonList.isEmpty) {
            return const Center(
              child: Text("Coming Soon list Empty"),
            );
          }
          return ListView.builder(
            itemCount: state.commingSoonList.length,
            itemBuilder: (context, index) {
              final movie = state.commingSoonList[index];
              if (movie.id == null) {
                return const SizedBox();
              }
              final date = DateTime.parse(movie.releaseDate!);
              final formatedDate=DateFormat.yMMMMd('en_US').format(date);
              return NewAndHotComSoonWidget(
                size: size,
                id: movie.id.toString(),
                mnthText: formatedDate.split(' ').first.substring(0,3),
                dayText: movie.releaseDate!.split('-')[1],
                movieName: movie.originalTitle ?? "No Title",
                posterPath: '$imageAppendUrl${movie.posterPath}',
                description: movie.overview ?? "",
              );
            },
          );
        },
      ),
    );
  }
}

class EveryOneWatching extends StatelessWidget {
  const EveryOneWatching({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        BlocProvider.of<HotAndNewBloc>(context).add(
          const loadDatainEveryoneWatching(),
        );
      },
    );
    return RefreshIndicator(
      onRefresh: () async{
        BlocProvider.of<HotAndNewBloc>(context).add(
          const loadDatainEveryoneWatching(),
        );
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text("Error"),
            );
          } else if (state.everyOneWatching.isEmpty) {
            return const Center(
              child: Text("Coming Soon list Empty"),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: state.everyOneWatching.length,
            itemBuilder: (context, index) {
              final tv = state.everyOneWatching[index];
              if (tv.id == null) {
                return const SizedBox();
              }
              return EveryOneWatchinWdget(
                movieName: tv.originalName ?? "No Title",
                posterPath: '$imageAppendUrl${tv.posterPath}',
                description: tv.overview ?? "",
              );
            },
          );
        },
      ),
    );
  }
}
