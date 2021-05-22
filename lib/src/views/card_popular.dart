import 'package:flutter/material.dart';
import 'package:practica2_2021/src/models/populardao.dart';

class CardPopular extends StatelessWidget {
  const CardPopular({
    Key key,
    @required this.popular,
  }) : super(key: key);

  final PopularDAO popular;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            offset: Offset(0.0,5.0),
            blurRadius: 2.5
          )
        ]
      ), 
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              child: FadeInImage(
                placeholder: AssetImage('assets/activity_indicator.gif'),
                image: NetworkImage('https://image.tmdb.org/t/p/w500/${popular.backdropPath}'),
                fadeInDuration: Duration(milliseconds: 100),
              ),
            ),
            Opacity(
              opacity: 0.5,
              child: Container(
                height: 55.0,
                color: Colors.black,
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(popular.title, style: TextStyle(color: Colors.white, fontSize: 12.0),),
                    FlatButton(
                      onPressed: (){
                        Navigator.pushNamed(context, '/detail',arguments: {
                          'title':popular.title,
                          'overview': popular.overview,
                          'posterpath': popular.posterPath,
                          'id': popular.id,
                          'backdropPath': popular.backdropPath,
                          'originalLanguage': popular.originalLanguage,
                          'originalTitle': popular.originalTitle,
                          'popularity': popular.popularity,
                          'releaseDate': popular.releaseDate,
                          'voteAverage': popular.voteAverage,
                          'voteCount': popular.voteCount,
                          }
                        ); //recibe un mapa de argumentos
                      }, 
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(Icons.chevron_right, color: Colors.white,)
                    )
                  ],
                ),
              ),
            )
          ]
        ),
      ), 
    );
  }
}