import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provieder.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widget/widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvieder = Provider.of<MoviesProvieder>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pelicula Cines'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () =>
                showSearch(context: context, delegate: SearchMovieDelegate()),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          //Tarjetas principales
          CardSwiper(movies: moviesProvieder.onDisplayMovies),
          //Slide de peliculas
          MovieSlider(
            popularMovies: moviesProvieder.popularMovies,
            title: 'Populares',
            onNextPage: () => moviesProvieder.getOnPopularMovies(),
          )
        ],
      )),
    );
  }
}
