import 'package:dartz/dartz.dart';
import 'package:netflix_clone/domain/core/failures/main_failure.dart';
import 'package:netflix_clone/domain/hot_and_new_response/model/hot_and_new_response.dart';

abstract class HotandNewService {
  Future<Either<MainFailure, HotAndNewResponse>> getHotAndNewMovieData();
  Future<Either<MainFailure, HotAndNewResponse>> getHotAndNewTvData();
}
