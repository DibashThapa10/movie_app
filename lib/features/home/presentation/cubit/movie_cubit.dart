import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/data/repositories/movie_repository.dart';
import 'package:movie_app/features/home/presentation/cubit/movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit({required this.repository}) : super(InitialState()) {
    getTrendingMovies();
  }
  final MovieRepository repository;

 Future <void> getTrendingMovies() async {
    try {
      emit(LoadingState());
      final movies = await repository.getMovies();
      emit(LoadedState(movies));
    } catch (e) {
      emit(ErrorState());
    }
  }
}
