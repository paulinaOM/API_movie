import 'package:flutter/material.dart';
import 'package:practica2_2021/src/database/database_helper.dart';
import 'package:practica2_2021/src/models/populardao.dart';

class FavoriteButton extends StatefulWidget {
  FavoriteButton({
    Key key,
    @required this.movie,
  }) : super(key: key);

  final movie;

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState(movie);
}

class _FavoriteButtonState extends State<FavoriteButton> {
  Map<String,dynamic> movie;
  DatabaseHelper _database = DatabaseHelper();
  bool isPressed;
  
  _FavoriteButtonState(movie){
    this.movie = movie;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder( 
        future: _database.getFavMovie(movie['id']),
        builder: (BuildContext context, AsyncSnapshot<PopularDAO> snapshot){
          if(snapshot.hasError){
            return Center(
              child: Text("Has error in this favorite movie request"),
            );
          }else if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.data != null){
              isPressed = true;
            }
            else{
              isPressed = false;
            }
            
            return IconButton(
              icon: Icon(Icons.favorite,
              color:(isPressed) ? Colors.red : Colors.white38),
              onPressed: () {
                setState(() {
                  isPressed = !isPressed;
                  print(isPressed);
                  if(isPressed){
                    PopularDAO objMovie = PopularDAO(
                      id: movie['id'],
                      backdropPath:movie['backdropPath'],
                      originalLanguage: movie['originalLanguage'],
                      overview: movie['overview'],
                      popularity: movie['popularity'],
                      posterPath: movie['posterpath'],
                      releaseDate: movie['releaseDate'],
                      title: movie['title'],
                      voteAverage: movie['voteAverage'],
                      voteCount: movie['voteCount'],
                    );
                    _database.insert('tbl_favorites',objMovie.toJSON());
                  }
                  else{
                    _database.delete('tbl_favorites',movie['id']);
                  }
                });
              }
            ); 
          }else{ 
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      ),
    );
  }
}