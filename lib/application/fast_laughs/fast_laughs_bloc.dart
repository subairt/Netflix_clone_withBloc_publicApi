import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_clone/domain/downloads/i_downloads_repo.dart';
import 'package:netflix_clone/domain/downloads/models/downloads.dart';

part 'fast_laughs_event.dart';
part 'fast_laughs_state.dart';
part 'fast_laughs_bloc.freezed.dart';

final videoUrls = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
];

@injectable
class FastLaughsBloc extends Bloc<FastLaughsEvent, FastLaughsState> {
  FastLaughsBloc(
    IDownloadsRepo downloadService,
  ) : super(FastLaughsState.initial()) {
    on<Initialize>(
      (event, emit) async {
        emit(const FastLaughsState(
                videosList: [], isLoading: true, isError: false));
        // get trending movies
        final result = await downloadService.getDownloadsImages();
        final states = result.fold(
          (l) {
            return const FastLaughsState(
                videosList: [], isLoading: false, isError: true);
          },
          (resp) => FastLaughsState(
              videosList: resp, isLoading: false, isError: false),
        );

        emit(states);
      },
    );
  }
}
