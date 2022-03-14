import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app_gee/function.dart';
import 'package:movies_app_gee/models/genres.dart';
import 'package:movies_app_gee/screens/search_view.dart';
import 'package:movies_app_gee/screens/settings.dart';
import 'package:provider/provider.dart';

import '../api/endpoints.dart';
import '../models/movie.dart';
import '../theme/theme_state.dart';
import '../widgets/discover_movie_widget.dart';
import '../widgets/scrolling_movies_widget.dart';
import 'movie_detail.dart';

class MyHomePage extends StatefulWidget {
  static String id = 'MyHomePage';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Genres> _genres = [];

  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void _signOut() {
    _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    fetchGenres().then((value) {
      _genres = value.genres ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<ThemeState>(context);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          iconTheme:
              IconThemeData(color: state.themeData.colorScheme.secondary),
          title: Text("Movies", style: state.themeData.textTheme.bodyText1),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: state.themeData.textTheme.bodyText1,
            tabs: const <Tab>[
              const Tab(text: 'Discover', icon: Icon(Icons.movie_rounded)),
              const Tab(text: 'Top rated', icon: Icon(Icons.important_devices)),
              const Tab(text: 'Now Playing', icon: Icon(Icons.airplay_sharp)),
              const Tab(text: 'Popular', icon: Icon(Icons.movie_filter)),
              // const Tab(text: 'Search', icon: Icon(Icons.search)),
            ],
          ),
          actions: [
            ElevatedButton.icon(
              onPressed: () async {
                final Movie? result = await showSearch<Movie?>(
                    context: context,
                    delegate: MovieSearch(
                        themeData: state.themeData, genres: _genres));
                if (result != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MovieDetailPage(
                              movie: result,
                              themeData: state.themeData,
                              genres: _genres,
                              heroId: '${result.id}search')));
                }
              },
              icon: Icon(Icons.search),
              label: Text("Search"),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
        drawer: Theme(
          data: Theme.of(context).copyWith(
            primaryColor: state.themeData.primaryColor.withOpacity(0.5),
            // Set the transparency here
            canvasColor: Colors
                .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
          ),
          child: Drawer(
            child: SettingsPage(),
          ),
        ),
        body: TabBarView(physics: BouncingScrollPhysics(), children: [
          DiscoverMovies(
            themeData: state.themeData,
            genres: _genres,
          ),
          ScrollingMovies(
            themeData: state.themeData,
            title: 'Top Rated',
            api: Endpoints.topRatedUrl(1),
            genres: _genres,
          ),
          ScrollingMovies(
            themeData: state.themeData,
            title: 'Now Playing',
            api: Endpoints.nowPlayingMoviesUrl(1),
            genres: _genres,
          ),
          ScrollingMovies(
            themeData: state.themeData,
            title: 'Popular',
            api: Endpoints.popularMoviesUrl(1),
            genres: _genres,
          ),
          // IconButton(
          //   color: state.themeData.colorScheme.secondary,
          //   icon: Icon(Icons.search),
          //   onPressed: () async {
          //     final Movie? result = await showSearch<Movie?>(
          //         context: context,
          //         delegate:
          //             MovieSearch(themeData: state.themeData, genres: _genres));
          //     if (result != null) {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => MovieDetailPage(
          //                   movie: result,
          //                   themeData: state.themeData,
          //                   genres: _genres,
          //                   heroId: '${result.id}search')));
          //     }
          //   },
          // ),
        ]),
      ),
    );
  }
}
