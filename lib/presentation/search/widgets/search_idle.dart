import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/search/search_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/colors/constants.dart';
import 'package:netflix_clone/presentation/search/widgets/search_text_title.dart';

class SearchIdleWidgets extends StatelessWidget {
  const  SearchIdleWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SearchTextTitle(titles: "Top Searches"),
          khight,
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.isError) {
                  return const Center(
                    child: Text("Error while getting data"),
                  );
                } else if (state.idleList.isEmpty) {
                  return const Center(
                    child: Text("List is empty"),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    // return const TopSearchItemTile(imageurl: ,);
                    final movie = state.idleList[index];
                    return TopSearchItemTile(
                      imageurl: '$imageAppendUrl${movie.posterpath}',
                      title: movie.title ?? "No Title provided",
                    );
                  },
                  separatorBuilder: (
                    context,
                    index,
                  ) {
                    return khight15;
                  },
                  itemCount: state.idleList.length,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class TopSearchItemTile extends StatelessWidget {
  const TopSearchItemTile(
      {super.key, required, required this.imageurl, required this.title});

  final String imageurl;
  final String title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: size.width * 0.33,
          height: 65,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                imageurl,
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        const Icon(
          CupertinoIcons.play_circle,
          color: kwhiteColor,
          size: 40,
        ),
      ],
    );
  }
}
