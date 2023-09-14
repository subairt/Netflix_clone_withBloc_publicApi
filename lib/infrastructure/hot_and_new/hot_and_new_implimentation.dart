import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_clone/domain/core/api_ends_point.dart';
import 'package:netflix_clone/domain/core/failures/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/domain/hot_and_new_response/model/hot_and_new_response.dart';
import '../../domain/hot_and_new_response/hot_and_new_service.dart';

@LazySingleton(as: HotandNewService)
class HotAndNewImplimentation implements HotandNewService {
  @override
  Future<Either<MainFailure, HotAndNewResponse>> getHotAndNewMovieData() async {
    try {
      final Response response =
          await Dio(BaseOptions()).get(ApiEndPoints.hotAndNewMovie);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = HotAndNewResponse.fromJson(response.data);
        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (_) {
      return const Left(MainFailure.clientFailure());
    }
  }

  @override
  Future<Either<MainFailure, HotAndNewResponse>> getHotAndNewTvData() async {
    try {
      final Response response =
          await Dio(BaseOptions()).get(ApiEndPoints.hotAndNewTv);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = HotAndNewResponse.fromJson(response.data);
        return Right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (_) {
      return const Left(MainFailure.clientFailure());
    }
  }
}
