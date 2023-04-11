import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/presentation/cubit/movie_cubit.dart';
import 'package:movie_app/features/home/presentation/cubit/movie_state.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latest Movies'),
        centerTitle: true,
      ),
      body: BlocConsumer<MovieCubit, MovieState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is ErrorState) {
              return const Center(
                child: Icon(Icons.close),
              );
            } else if (state is LoadedState) {
              final movies = state.movies;
              return ListView.builder(
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                        title: Text(movies[index].title),
                        subtitle: Text(movies[index].releaseDate),
                        trailing: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(movies[index].image),
                        )),
                  );
                },
              );
            }

            return Container();
          }),
    );
  }
}
