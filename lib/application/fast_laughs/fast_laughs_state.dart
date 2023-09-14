part of 'fast_laughs_bloc.dart';

@freezed
class FastLaughsState with _$FastLaughsState {
  const factory FastLaughsState({
    required List<Downloads> videosList,
    required bool isLoading,
    required bool isError,
  }) = _Initial;

  factory FastLaughsState.initial() =>
      const FastLaughsState(videosList: [], isLoading: true, isError: false);
}
