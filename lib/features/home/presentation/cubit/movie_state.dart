import 'package:equatable/equatable.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';

// Equtable package helps in comparison in dart and flutter overriding the == for us along with hashcode

abstract class MovieState extends Equatable {}

class InitialState extends MovieState {
  @override
  List<Object> get props => [];
}

class LoadingState extends MovieState {
  @override
  List<Object> get props => [];
}

class LoadedState extends MovieState {
  LoadedState(this.movies);
  final List<MovieModel> movies;
  @override
  List<Object> get props => [movies];
}

class ErrorState extends MovieState {
  @override
  List<Object> get props => [];
}
