import 'package:flutter/material.dart';
import 'package:practica2_2021/src/models/populardao.dart';
import 'package:practica2_2021/src/network/api_popular.dart';
import 'package:practica2_2021/src/views/card_popular.dart';

class PopularScreen extends StatefulWidget {
  PopularScreen({Key key}) : super(key: key);

  _PopularScreenState createState()=> _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen>{

    ApiPopular apiPopular;

    @override
    void initState(){
      super.initState();
      apiPopular = ApiPopular();
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
          title: Text("Popular movies"),
        ),
        body:FutureBuilder( //Future builder siempre retorna un widget
          future: apiPopular.getAllPopular(),
          builder: (BuildContext context, AsyncSnapshot<List<PopularDAO>> snapshot){
            if(snapshot.hasError){
              return Center(
                child: Text("Has error in this request"),
              );
            }else if(snapshot.connectionState == ConnectionState.done){
              return _listPopularMovies(snapshot.data); //Manda una lista de tipo populardao a listpopularmovies
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

  Widget _listPopularMovies(List<PopularDAO> movies) {
    return ListView.builder(
      itemBuilder: (context, index){
        PopularDAO popular = movies[index];
        return CardPopular(popular: popular);
      },
      itemCount: movies.length,
    ); //Cuando no sabemos cuantos items tendrá usamos .builder
  }

