import 'package:dio/dio.dart';
import 'package:movie_app/core/helpers/api_endpoints.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';

class MovieRepository {
  MovieRepository(this.dio);
  final Dio dio;

  Future<List<MovieModel>> getMovies() async {
    try {
      final response = await dio.get(ApiEndPoints.getMoviesListUrl);

      final movies = List<MovieModel>.of(response.data['results']
          .map<MovieModel>((json) => MovieModel(
              title: json['title'],
              image: 'https://image.tmdb.org/t/p/w185${json['poster_path']}',
              releaseDate: json['release_date'])));
      print("This is the response of getMovies: ${response.data['results']}");
      return movies;
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }
}
