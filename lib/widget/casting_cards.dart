import 'package:flutter/cupertino.dart';
import 'package:peliculas/providers/movies_provieder.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class CastingCard extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CastingCard(this.movieId);

  final int movieId;

  @override
  Widget build(BuildContext context) {
    final moviesProvieder =
        Provider.of<MoviesProvieder>(context, listen: false);
    return FutureBuilder(
        future: moviesProvieder.getMovieCast(movieId),
        builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox(
                height: 180, child: CupertinoActivityIndicator());
          }

          final List<Cast> cast = snapshot.data!;

          return Container(
            width: double.infinity,
            height: 180,
            margin: const EdgeInsets.only(bottom: 30),
            child: ListView.builder(
              itemCount: cast.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, int index) => _CastCard(cast[index]),
            ),
          );
        });
  }
}

class _CastCard extends StatelessWidget {
  const _CastCard(this.actor);

  final Cast actor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 100,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.fullprofilePathImg),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
