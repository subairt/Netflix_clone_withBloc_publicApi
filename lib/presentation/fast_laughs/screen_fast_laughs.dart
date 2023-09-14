import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/fast_laughs/fast_laughs_bloc.dart';
import 'package:netflix_clone/presentation/fast_laughs/widgets/video_list_item.dart';

class ScreenFastLaughs extends StatelessWidget {
  const ScreenFastLaughs({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FastLaughsBloc>(context).add(const Initialize());
    });
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<FastLaughsBloc, FastLaughsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            } else if (state.isError) {
              return const Center(
                child: Text("Error while getting data"),
              );
            } else if (state.videosList.isEmpty) {
              return const Center(
                child: Text("Video not found"),
              );
            } else {
              return PageView(
                scrollDirection: Axis.vertical,
                children: List.generate(
                  state.videosList.length,
                  (index) => VideoListitemInheritedWidget(
                    key: Key(index.toString()),
                    widgets: VideoListItem(index: index),
                    movieData: state.videosList[index],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
