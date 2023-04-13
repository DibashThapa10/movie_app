import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/presentation/cubit/movie_cubit.dart';
import 'package:movie_app/features/home/presentation/cubit/movie_state.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  late final MovieCubit _cubit;
  double currentIndex = 0;
  bool isRefreshing = false;
  @override
  void initState() {
    _cubit = context.read<MovieCubit>();
    _cubit.getTrendingMovies();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie App'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            isRefreshing = true;
          });
          await _cubit.getTrendingMovies();
          setState(() {
            isRefreshing = false;
          });
        },
        child: BlocConsumer<MovieCubit, MovieState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is LoadingState && !isRefreshing) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else if (state is ErrorState) {
                return const Center(
                  child: Text("Something went wrong"),
                );
              } else if (state is LoadedState) {
                final movies = state.movies;
                return Column(
                  children: [
                    CarouselSlider.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index, realIndex) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image:
                                              NetworkImage(movies[index].image),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                movies[index].title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index.toDouble();
                            });
                          },
                          autoPlay: true,
                          initialPage: 0,
                          enlargeCenterPage: true,
                          viewportFraction: 0.8,
                          aspectRatio: 1.2),
                    ),
                    const SizedBox(height: 10),
                    DotsIndicator(
                      dotsCount: movies.length,
                      position: currentIndex,
                      decorator: DotsDecorator(
                        activeColor: Theme.of(context).primaryColor,
                        color: Colors.grey.shade300,
                        size: const Size.square(9.0),
                        spacing: const EdgeInsets.symmetric(horizontal: 3),
                        activeSize: const Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 25,
                      width: double.infinity,
                      color: Theme.of(context).canvasColor,
                      child: const Text(
                        "Trending Movies",
                        style: TextStyle(
                            color: Colors.indigo,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ).animate().fade(duration: 1000.ms).slideX(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          return Card(
                              child: ListTile(
                                      title: Text(movies[index].title),
                                      subtitle: Row(
                                        children: [
                                          Text(movies[index].releaseDate),
                                          const SizedBox(
                                            width: 50,
                                          ),
                                          const Icon(
                                            Icons.star_rounded,
                                            color: Colors.amber,
                                            size: 18,
                                          ),
                                          Text(
                                            movies[index].rating.toString(),
                                            style: const TextStyle(
                                                color: Colors.amber),
                                          ),
                                        ],
                                      ),
                                      trailing: CircleAvatar(
                                        radius: 30,
                                        backgroundImage:
                                            NetworkImage(movies[index].image),
                                      ))
                                  .animate()
                                  .fade(duration: 1000.ms)
                                  .slideX());
                        },
                      ),
                    ),
                  ],
                );
              }

              return Container();
            }),
      ),
    );
  }
}
