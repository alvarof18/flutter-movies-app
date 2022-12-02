import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provieder.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class SearchMovieDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Busqueda Peliculas';
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const SizedBox(
        child: Center(
          child: Icon(
            Icons.movie_creation_outlined,
            color: Colors.black38,
            size: 150,
          ),
        ),
      );
    }

    final moviesProvieder =
        Provider.of<MoviesProvieder>(context, listen: false);

    moviesProvieder.getSuggestionsByQuery(query);

    return StreamBuilder(
        stream: moviesProvieder.suggestionStream,
        builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox(
              child: Center(
                child: Icon(
                  Icons.movie_creation_outlined,
                  color: Colors.black38,
                  size: 150,
                ),
              ),
            );
          }

          final movies = snapshot.data!;

          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (_, int index) => _MovieItems(movies[index]));
        });
  }
}

class _MovieItems extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const _MovieItems(this.movie);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    movie.Heroid = 'search-${movie.id}';
    return ListTile(
      leading: Hero(
        tag: movie.Heroid!,
        child: FadeInImage(
            placeholder: const AssetImage('assets/no-image.jpg'),
            image: NetworkImage(movie.fullPosterImg),
            fit: BoxFit.contain,
            width: 50),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
    );
  }
}
