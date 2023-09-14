import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
// import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_clone/domain/core/failures/main_failure.dart';
import 'package:netflix_clone/domain/downloads/i_downloads_repo.dart';
import 'package:netflix_clone/domain/downloads/models/downloads.dart';

part 'downloads_event.dart';
part 'downloads_state.dart';
part 'downloads_bloc.freezed.dart';

@Injectable()
class DownloadsBloc extends Bloc<DownloadsEvevt, DownloadsState> {
  final IDownloadsRepo downloadsRepo;
  DownloadsBloc(this.downloadsRepo) : super(DownloadsState.intial()) {
    on<_GetDownloadsImages>(
      (event, emit) async {
        emit(
          state.copyWith(
            isLoading: true,
            downloadsFailureOrSuccessOption: none(),
          ),
        );
        final Either<MainFailure, List<Downloads>> downloadsOption =
            await downloadsRepo.getDownloadsImages();
        emit(
          downloadsOption.fold(
            (failure) => state.copyWith(
              isLoading: false,
              downloadsFailureOrSuccessOption: some(
                Left(failure),
              ),
            ),
            (success) => state.copyWith(
              isLoading: false,
              downloads: success,
              downloadsFailureOrSuccessOption: Some(
                Right(success),
              ),
            ),
          ),
        );
      },
    );
  }
}
