import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_clone/domain/core/failures/main_failure.dart';
import 'package:netflix_clone/domain/hot_and_new_response/hot_and_new_service.dart';
import 'package:netflix_clone/domain/hot_and_new_response/model/hot_and_new_response.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  final HotandNewService hotandNewService;
  HotAndNewBloc(this.hotandNewService) : super((HotAndNewState.initial())) {
    on<loadDateinComingSoon>(
      (event, emit) async {
        emit(
          const HotAndNewState(
            commingSoonList: [],
            everyOneWatching: [],
            isLoading: true,
            hasError: false,
          ),
        );
        final result = await hotandNewService.getHotAndNewMovieData();
        final newState = result.fold(
          (MainFailure failure) {
            return const HotAndNewState(
                commingSoonList: [],
                everyOneWatching: [],
                isLoading: false,
                hasError: true);
          },
          (HotAndNewResponse response) {
            return HotAndNewState(
                commingSoonList: response.results,
                everyOneWatching: state.everyOneWatching,
                isLoading: false,
                hasError: false);
          },
        );
        emit(newState);
      },
    );
    on<loadDatainEveryoneWatching>(
      (event, emit) async {
        emit(
          const HotAndNewState(
            commingSoonList: [],
            everyOneWatching: [],
            isLoading: true,
            hasError: false,
          ),
        );
        final result = await hotandNewService.getHotAndNewTvData();
        final newState = result.fold(
          (MainFailure failure) {
            return const HotAndNewState(
                commingSoonList: [],
                everyOneWatching: [],
                isLoading: false,
                hasError: true);
          },
          (HotAndNewResponse response) {
            return HotAndNewState(
                commingSoonList: state.commingSoonList,
                everyOneWatching: response.results,
                isLoading: false,
                hasError: false);
          },
        );
        emit(newState);
      },
    );
  }
}
