import 'package:flutter/material.dart';
import 'package:movies_app_gee/screens/movie_detail.dart';

import '../constants/api_constants.dart';
import '../function.dart';
import '../models/genres.dart';
import '../models/movie.dart';

class ScrollingMovies extends StatefulWidget {
  final ThemeData themeData;
  final String? api, title;
  final List<Genres> genres;
  ScrollingMovies(
      {required this.themeData, this.api, this.title, required this.genres});
  @override
  _ScrollingMoviesState createState() => _ScrollingMoviesState();
}

class _ScrollingMoviesState extends State<ScrollingMovies> {
  List<Movie>? moviesList;
  @override
  void initState() {
    super.initState();
    fetchMovies(widget.api!).then((value) {
      setState(() {
        moviesList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: moviesList == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: moviesList!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MovieDetailPage(
                                  movie: moviesList![index],
                                  themeData: widget.themeData,
                                  genres: widget.genres,
                                  heroId:
                                      '${moviesList![index].id}${widget.title}')));
                    },
                    child: Hero(
                      tag: '${moviesList![index].id}${widget.title}',
                      child: Container(
                        width: 100,
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: FadeInImage(
                                image: NetworkImage(TMDB_BASE_IMAGE_URL +
                                    'w500/' +
                                    moviesList![index].posterPath!),
                                fit: BoxFit.cover,
                                placeholder:
                                    AssetImage('assets/images/loading.gif'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                moviesList![index].title!,
                                style: widget.themeData.textTheme.bodyText1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
