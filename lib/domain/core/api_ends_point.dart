import 'package:netflix_clone/core/colors/strings.dart';
import 'package:netflix_clone/infrastructure/api_key.dart';

class ApiEndPoints {
  static const downloads = "$kBaseurl/trending/all/day?api_key=$apikey";
  static const search = "$kBaseurl/search/movie?api_key=$apikey";
  static const hotAndNewMovie = "$kBaseurl/discover/movie?api_key=$apikey";
  static const hotAndNewTv = "$kBaseurl/discover/tv?api_key=$apikey";
}
