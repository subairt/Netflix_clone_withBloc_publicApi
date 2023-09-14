part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState(
      {
      required String stateId,
      required List<HotAndNewData> pastYearMovielist,
      required List<HotAndNewData> trendingMovieList,
      required List<HotAndNewData> tenceDramasMovieList,
      required List<HotAndNewData> southIndianMovieList,
      required List<HotAndNewData> trendingTvList,
      required bool isLoading,
      required bool hasError}) = _Initial;

  factory HomeState.initial() => const HomeState(
        pastYearMovielist: [],
        trendingMovieList: [],
        tenceDramasMovieList: [],
        southIndianMovieList: [],
        trendingTvList: [],
        isLoading: false,
        hasError: false,
        stateId: '0'
      );
}
