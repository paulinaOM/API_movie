import 'package:flutter/material.dart';
import 'package:practica2_2021/src/database/database_helper.dart';
import 'package:practica2_2021/src/models/populardao.dart';
import 'package:practica2_2021/src/views/card_favorite.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({Key key}) : super(key: key);

  _FavoriteScreenState createState()=> _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>{
    DatabaseHelper _database = DatabaseHelper();

    @override
    void initState(){
      super.initState();
    }

    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: (){
              Navigator.pushNamed(context, '/dashboard');
              
            },
          ),
          title: Text("Favorite movies"),
        ),
        body:FutureBuilder( 
          future: _database.getAllFavMovies(),
          builder: (BuildContext context, AsyncSnapshot<List<PopularDAO>> snapshot){
            if(snapshot.hasError){
              return Center(
                child: Text("Has error in this request"),
              );
            }else if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.data!=null){
                return _listFavoriteMovies(snapshot.data); 
              }
              else{
                return Center(
                  child: Text("No data available"),
                );
              }
            }else{ //Si tarda mucho el consumo mostrará una barra de progreso
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        )
      );
    }
  }

  Widget _listFavoriteMovies(List<PopularDAO> movies) {
    return ListView.builder(
      itemBuilder: (context, index){
        PopularDAO favorite = movies[index];
        return CardFavorite(favorite: favorite);
      },
      itemCount: movies.length,
    ); //Cuando no sabemos cuantos items tendrá usamos .builder
  }

