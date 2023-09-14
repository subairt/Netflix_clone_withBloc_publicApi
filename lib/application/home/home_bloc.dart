import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_clone/domain/core/failures/main_failure.dart';
import 'package:netflix_clone/domain/hot_and_new_response/hot_and_new_service.dart';
import 'package:netflix_clone/domain/hot_and_new_response/model/hot_and_new_response.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotandNewService homeService;
  HomeBloc(this.homeService) : super(HomeState.initial()) {
    /*
    On event get homescreen data
    */
    on<HomeEvent>(
      (event, emit) async {
        // Send loading to UI

        emit(state.copyWith(isLoading: true, hasError: false));

        // get data
        final _movieResult = await homeService.getHotAndNewMovieData();
        final _tvResult = await homeService.getHotAndNewMovieData();

        // trasform data
        final state1 = _movieResult.fold(
          (MainFailure failure) {
            // ignore: prefer_const_constructors
            return HomeState(
              stateId: DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovielist: [],
              trendingMovieList: [],
              tenceDramasMovieList: [],
              southIndianMovieList: [],
              trendingTvList: [],
              isLoading: false,
              hasError: true,
            );
          },
          (HotAndNewResponse response) {
            final pastYear = response.results;
            final trending = response.results;
            final dramas = response.results;
            final southIndian = response.results;
            pastYear.shuffle();
            trending.shuffle();
            dramas.shuffle();
            southIndian.shuffle();
            return HomeState(
              stateId: DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovielist: pastYear,
              trendingMovieList: trending,
              tenceDramasMovieList: dramas,
              southIndianMovieList: southIndian,
              trendingTvList: state.trendingTvList,
              isLoading: false,
              hasError: false,
            );
          },
        );

        emit(state1);

        final state2 = _tvResult.fold(
          (MainFailure failure) {
            return  HomeState(
              stateId: DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovielist: [],
              trendingMovieList: [],
              tenceDramasMovieList: [],
              southIndianMovieList: [],
              trendingTvList: [],
              isLoading: false,
              hasError: true,
            );
          },
          (HotAndNewResponse response) {
            final top10List = response.results;
            return HomeState(
              stateId: DateTime.now().millisecondsSinceEpoch.toString(),
              pastYearMovielist: state.pastYearMovielist,
              trendingMovieList: state.trendingMovieList,
              tenceDramasMovieList: state.tenceDramasMovieList,
              southIndianMovieList: state.southIndianMovieList,
              trendingTvList: top10List,
              isLoading: false,
              hasError: false,
            );
          },
        );

        // send to Ui
        emit(state2);
      },
    );
  }
}
