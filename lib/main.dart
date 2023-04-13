import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/data/repositories/movie_repository.dart';
import 'package:movie_app/features/home/presentation/cubit/movie_cubit.dart';
import 'package:movie_app/features/home/presentation/pages/movie_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      home: BlocProvider<MovieCubit>(
          create: (BuildContext context) =>
              MovieCubit(repository: MovieRepository(Dio())),
          child: const MoviesPage()),
    );
  }
}
