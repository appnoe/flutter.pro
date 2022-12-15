part of 'show_list_bloc.dart';

@immutable
abstract class ShowListEvent {}

class LoadSpecificMovie extends ShowListEvent {
  final String movieName;
  LoadSpecificMovie({required this.movieName});
}