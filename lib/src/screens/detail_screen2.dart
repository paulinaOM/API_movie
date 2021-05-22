import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practica2_2021/src/models/actordao.dart';
import 'package:practica2_2021/src/models/videodao.dart';
import 'package:practica2_2021/src/network/api_actor.dart';
import 'package:practica2_2021/src/network/api_popular.dart';
import 'package:practica2_2021/src/views/youtube_screen.dart';

class DetailScreen2 extends StatefulWidget {
  DetailScreen2({Key key}) : super(key: key);

  @override
  _DetailScreen2State createState() => _DetailScreen2State();
}

class _DetailScreen2State extends State<DetailScreen2> {
  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context).settings.arguments as Map<String,dynamic>; //Recuperar los argumentos
    return Material(
      type: MaterialType.transparency,
      child: CustomScrollView ( 
        slivers: <Widget> [ 
          SliverAppBar ( 
            title: Text ('Movie Detail'), 
            backgroundColor: Colors.black,
            expandedHeight: 400.0, 
            flexibleSpace: FlexibleSpaceBar ( 
              background: _videoTrailer(movie['id']), 
            ), 
          ), 
          SliverList(
            delegate: SliverChildListDelegate ( 
              [ 
                Container(child: _movieData(movie['posterpath'],movie['title'], movie['voteAverage'],movie['overview'], movie['releaseDate'], movie['originalLanguage'] ), color: Colors.black,),
                Container(color: Colors.black, padding: EdgeInsets.symmetric(vertical: 10), child: Text('Overview', style: TextStyle(fontSize: 20),)),
                Container(child: Text(movie['overview'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, height: 1.5),), color: Colors.black,),
                _moviePoster(movie['posterpath']),
                Container(color: Colors.black, padding: EdgeInsets.symmetric(vertical: 10), child: Text('Cast', style: TextStyle(fontSize: 20),)),
                _cast(movie['id']),
              ], 
            ), 
          ), 
        ], 
      ),
    );
  }
}

Widget _movieData(String poster, String title, double voteAverage, String overview, String releaseDate, String originalLanguaje){
  releaseDate = releaseDate.substring(0,4);
  originalLanguaje= originalLanguaje.toUpperCase();
  return Row(
    children: [
      Card(
        elevation: 10.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image(
            image: NetworkImage('https://image.tmdb.org/t/p/w200/$poster'),
            height: 150,
            fit: BoxFit.fill,
          ),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),
            overflow: TextOverflow.clip,
            //textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(5,0,0,0), child: Text(voteAverage.toString(), style: TextStyle(fontSize: 12,),)),
                Icon(Icons.star, color: Colors.yellowAccent[700],size: 16,),
                Padding(padding: EdgeInsets.all(5),child: Text('Year: $releaseDate', style: TextStyle(fontSize: 12,),)),
                Padding(padding: EdgeInsets.all(5),child: Text('Languaje: $originalLanguaje', style: TextStyle(fontSize: 12,),)),
              ],
            ),
          ),
          //Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10),child: Text(overview, style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, height: 1.5),)),
        ],
      )
    ],
  );
}

Widget _moviePoster(String posterpath){
  return Container(
    height: 400,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage('https://image.tmdb.org/t/p/w200/$posterpath'),
        fit: BoxFit.fill
      )
    ),
  );
}

Widget _cast(movieId){
  print(movieId);
  ApiActor apiActor = ApiActor();
  return Container(
    padding: EdgeInsets.all(5),
    height: 200,
    color: Colors.black,
    child: FutureBuilder( //Future builder siempre retorna un widget
      future: apiActor.getAllActors(movieId),
      builder: (BuildContext context, AsyncSnapshot<List<ActorDAO>> snapshot){
        if(snapshot.hasError){
          return Center(
            child: Text("Has error in this cast request"),
          );
        }else if(snapshot.connectionState == ConnectionState.done){
          return _listCast(snapshot.data); 
        }else{ //Si tarda mucho el consumo mostrará una barra de progreso
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    ),
  );
}

Widget _listCast(List<ActorDAO> actors) {
  return ListView.builder(
    itemBuilder: (context, index){
      ActorDAO actor = actors[index];
      return Card(
        color: Colors.black26,
        child: Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage('https://image.tmdb.org/t/p/w500${actor.profilePath}'),
                    radius: 33,
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${actor.character}'),
                Text('${actor.name}', style: TextStyle(fontSize: 13, color: Colors.white38),),
              ],
            ),
          ],
        ),
      );
    },
    itemCount: 8,
  ); 
}

Widget _videoTrailer(int movieId){
  print(movieId);
  ApiPopular apiPopular = ApiPopular();
  return FutureBuilder( 
    future: apiPopular.getVideoKey(movieId),
    builder: (BuildContext context, AsyncSnapshot<List<VideoDAO>> snapshot){
      if(snapshot.hasError){
        return Center(
          child: Text("Has error in this video request"),
        );
      }else if(snapshot.connectionState == ConnectionState.done){
        String videoId =snapshot.data[0].key;
        print(videoId);
        return YoutubeScreen(videoId: videoId,);
      }else{ 
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    }
  );
}

