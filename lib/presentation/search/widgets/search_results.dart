import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/search/search_bloc.dart';
import 'package:netflix_clone/core/colors/constants.dart';
import 'package:netflix_clone/presentation/search/widgets/search_text_title.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SearchTextTitle(titles: "Movies & TV"),
          khight,
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                return GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1 / 1.5,
                  children: List.generate(
                    state.searchResultList.length,
                    (index) {
                      final movie = state.searchResultList[index];
                      return SearchResultCard(
                        imageurl: movie.posterImageUrl,
                      
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({super.key, required this.imageurl});

  final String imageurl;

  @override
  Widget build(BuildContext context) {
    const un=null;
    return imageurl.isEmpty || imageurl == "$imageAppendUrl$un" ? const Center(child: CircularProgressIndicator(),): Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imageurl),
        ),
      ),
    );
  }
}
