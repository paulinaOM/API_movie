import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practica2_2021/src/models/actordao.dart';
import 'package:practica2_2021/src/models/backdropdao.dart';
import 'package:practica2_2021/src/models/videodao.dart';
import 'package:practica2_2021/src/network/api_actor.dart';
import 'package:practica2_2021/src/network/api_popular.dart';
import 'package:practica2_2021/src/screens/favorite_screen.dart';
import 'package:practica2_2021/src/screens/popular_screen.dart';
import 'package:practica2_2021/src/views/youtube_screen.dart';
import 'package:practica2_2021/src/views/favorite_button.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context).settings.arguments as Map<String,dynamic>; //Recuperar los argumentos
    
    return Material(
      type: MaterialType.transparency,
      child: 
      CustomScrollView ( 
        slivers: <Widget> [ 
          SliverAppBar ( 
            leading: IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: (){
                if(movie['isFavorite']){
                  Navigator.pushAndRemoveUntil(
                    context, 
                    MaterialPageRoute(builder: (BuildContext context)=> FavoriteScreen()), 
                    (route) => false
                  );
                }
                else{
                  Navigator.pushAndRemoveUntil(
                    context, 
                    MaterialPageRoute(builder: (BuildContext context)=> PopularScreen()), 
                    (route) => false
                  );
                }
              },
            ),
            title: Text (movie['title']), 
            backgroundColor: Colors.black,
            expandedHeight: 400.0, 
            flexibleSpace: FlexibleSpaceBar ( 
              background: _videoTrailer(movie['id']), 
            ), 
            actions: <Widget>[
              FavoriteButton(movie: movie)
            ],
          ), 
          SliverList(
            delegate: SliverChildListDelegate ( 
              [ 
                Container(child: _movieData(movie), color: Colors.black,),
                _title('Synopsis'),
                Container(child: Text(movie['overview'], style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, height: 1.5),), color: Colors.black,),
                _title('Photos'),
                _photos(movie['id']),
                _title('Cast'),
                _cast(movie['id']),
              ], 
            ), 
          ), 
        ], 
      ),
    );
  }
}

Widget _title(String title){
  return Container(
    color: Colors.black, 
    padding: EdgeInsets.symmetric(vertical: 20), 
    child: Text(title, 
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    )
  );
}

Widget _movieData(movie){
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _poster(movie['posterpath']),
        SizedBox(width: 10.0),
        Expanded(child: _movieInfo(movie))
      ],
    ),
  );
}

Widget _poster(String posterpath){
  return Card(
    elevation: 5.0,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image(
        image: NetworkImage('https://image.tmdb.org/t/p/w200/$posterpath'),
        height: 150,
      ),
    ),
  );
}

Widget _movieInfo(movie){
  var releaseDate = movie['releaseDate'].substring(0,4);
  var originalLanguaje= movie['originalLanguage'].toUpperCase();
  var ratingStars = (movie['voteAverage'].toInt())/2;
  var stars = <Widget>[];

  for (var i = 1; i <= 5; i++) {
    var color = i <= ratingStars ? Colors.yellowAccent[700] : Colors.white30;
    var star = Icon(
      Icons.star,
      color: color,
    );
    stars.add(star);
  }

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(movie['title'],
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,),
        overflow: TextOverflow.clip,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(movie['voteAverage'].toString(), style: TextStyle(fontSize: 20,),),
              Text('Year: $releaseDate', style: TextStyle(fontSize: 15,color: Colors.white30, height: 1.5),),
            ],
          ),
          SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: stars,),
              Text('Languaje: $originalLanguaje', style: TextStyle(fontSize: 15,color: Colors.white30, height: 1.5),),
            ],
          ),
        ],
      ),
    ],
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

Widget _cast(int movieId){
  print(movieId);
  ApiActor apiActor = ApiActor();
  return Container(
    height: 150,
    color: Colors.black,
    child: FutureBuilder( 
      future: apiActor.getAllActors(movieId),
      builder: (BuildContext context, AsyncSnapshot<List<ActorDAO>> snapshot){
        if(snapshot.hasError){
          return Center(
            child: Text("Has error in this cast request"),
          );
        }else if(snapshot.connectionState == ConnectionState.done){
          return _listCast(snapshot.data); 
        }else{ 
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
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index){
      String imagePath='';
      ActorDAO actor = actors[index];
      (actor.profilePath!=null && actor.profilePath!='')? imagePath='https://image.tmdb.org/t/p/w500${actor.profilePath}': imagePath='https://assets.stickpng.com/images/585e4beacb11b227491c3399.png';
      
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Card(
          color: Colors.black,
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white38,
                backgroundImage: NetworkImage(imagePath),
                radius: 50,
              ),
              Text('${actor.character}'),
              Text('${actor.name}', style: TextStyle(fontSize: 13, color: Colors.white38),),
            ],
          ),
        ),
      );
    },
    itemCount: actors.length,
  ); 
}

Widget _photos(int movieId){
  print(movieId);
  ApiPopular apiPopular = ApiPopular();
  return Container(
    height: 150,
    color: Colors.black,
    child: FutureBuilder( 
      future: apiPopular.getMovieImages(movieId),
      builder: (BuildContext context, AsyncSnapshot<List<BackdropImageDAO>> snapshot){
        if(snapshot.hasError){
          return Center(
            child: Text("Has error in this photo request"),
          );
        }else if(snapshot.connectionState == ConnectionState.done){
          return _listImages(snapshot.data); 
        }else{ 
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    ),
  );
}

Widget _listImages(List<BackdropImageDAO> images) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    
    itemBuilder: (context, index){
      String imagePath='';
      BackdropImageDAO image = images[index];
      (image.filePath!=null && image.filePath!='')? imagePath='https://image.tmdb.org/t/p/w500${image.filePath}': null;
      
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image(
            image: NetworkImage(imagePath),
            height: 200,
            fit: BoxFit.fill,
          ),
        ),
      );
    },
    itemCount: images.length,
  ); 
}

