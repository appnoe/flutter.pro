part of 'show_list_bloc.dart';

@immutable
abstract class ShowListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ShowListInitial extends ShowListState {}

class ShowListLoading extends ShowListState {}

class ShowListSuccess extends ShowListState {
  final List<TVMazeSearchResult> searchResult;
  ShowListSuccess(this.searchResult);
}

class ShowListFailure extends ShowListState {
  final String error;
  ShowListFailure(this.error);
}
