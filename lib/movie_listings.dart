import 'package:flutter/material.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/models/popular.dart';
import 'package:movie_app/service/movie_service.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'detail_screen.dart';

class MovieListings extends StatefulWidget {
  @override
  _MovieListingsState createState() => _MovieListingsState();
}

class _MovieListingsState extends State<MovieListings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Movie Listings',
          style: TextStyle(
              fontFamily: 'Pacifico',
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.orangeAccent),
      ),
      body: RefreshIndicator(
        child: _buildBody(context),
        onRefresh: () {
          return Future.delayed(Duration(seconds: 1), () {
            _buildBody(context);
          });
        },
      ),
    );
  }

// 1
  FutureBuilder<Response<Popular>> _buildBody(BuildContext context) {
    return FutureBuilder<Response<Popular>>(
      // 2
      future: Provider.of<MovieService>(context).getPopularMovies(),
      builder: (context, snapshot) {
        // 3
        if (snapshot.connectionState == ConnectionState.done) {
          // 4
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
            );
          }
          // 5
          final popular = snapshot.data.body;
          // 6
          return _buildMovieList(context, popular);
        } else {
          // 7
          // Show a loading indicator while waiting for the movies
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildMovieList(BuildContext context, Popular popular) {
    return ListView.builder(
      itemCount: popular.results.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailScreen(popular: popular, index: index),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 150,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              IMAGE_URL + popular.results[index].posterPath),
                          fit: BoxFit.contain),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 200,
                      child: Column(
                        children: <Widget>[
                          Text(
                            popular.results[index].title,
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Expanded(
                            child: Container(
                              child: AutoSizeText(
                                popular.results[index].overview,
                                maxLines: 12,
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static const String IMAGE_URL = "https://image.tmdb.org/t/p/w500/";
}
