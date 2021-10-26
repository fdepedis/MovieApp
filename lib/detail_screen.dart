import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/popular.dart';

class DetailScreen extends StatelessWidget {
  final Popular popular;
  final int index;

  DetailScreen({Key key, @required this.popular, @required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Colors.black;

    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        popular.results[index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.star,
                color: Colors.red,
              ),
              Text(popular.results[index].voteAverage.toString()),
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Release Date: ' + popular.results[index].releaseDate,
                      ),
                    ),
                  ],
                ),
              ),
              /*Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Adult: ',
                ),
              ),*/
              Icon(
                Icons.supervised_user_circle,
                color: (popular.results[index].adult == false)
                    ? Colors.green
                    : Colors.red,
              ),
            ],
          ),
        ],
      ),
    );

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.call, 'CALL'),
          _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(color, Icons.share, 'SHARE'),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        popular.results[index].overview,
        softWrap: true,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Film Details",
          style: TextStyle(
              fontFamily: 'Pacifico',
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Expanded(
            child: Container(
              width: 500,
              height: 240,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        IMAGE_URL + popular.results[index].backdropPath),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          titleSection,
          buttonSection,
          textSection,
        ],
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  static const String IMAGE_URL = "https://image.tmdb.org/t/p/w500/";
}
