import 'package:flutter/material.dart';
import 'package:movies_app_gee/models/genres.dart';

import '../api/endpoints.dart';
import '../widgets/particular_genre_movie_widget.dart';

class GenreMovies extends StatelessWidget {
  final ThemeData themeData;
  final Genres genre;
  final List<Genres> genres;

  GenreMovies(
      {required this.themeData, required this.genre, required this.genres});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.primaryColor,
        title: Text(
          genre.name!,
          style: themeData.textTheme.headline5,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: themeData.colorScheme.secondary,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ParticularGenreMovies(
        themeData: themeData,
        api: Endpoints.getMoviesForGenre(genre.id!, 1),
        genres: genres,
      ),
    );
  }
}
