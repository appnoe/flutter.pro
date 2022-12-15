import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../api/api.dart';
import '../../../../common/model/tvmazesearchresult.dart';

part 'show_list_event.dart';
part 'show_list_state.dart';

class ShowListBloc extends Bloc<ShowListEvent, ShowListState> {
  final Api api;
  ShowListBloc(this.api) : super(ShowListInitial()) {
    on<LoadSpecificMovie>(_onLoadSpecificMovie);
  }

  Future<void> _onLoadSpecificMovie(
    LoadSpecificMovie event,
    Emitter<ShowListState> emit,
  ) async {
    emit(ShowListLoading());

    try {
      final result = await api.fetchShow(event.movieName);
      if (result != null) {
        emit(ShowListSuccess(result));
      } else {
        throw 'result is null';
      }
    } catch (error) {
      emit(ShowListFailure(error.toString()));
    }

  }
}
