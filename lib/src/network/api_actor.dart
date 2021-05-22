import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:practica2_2021/src/models/actordao.dart';

class ApiActor{
  final URL_CAST = 'https://api.themoviedb.org/3/movie/';
  Client http = Client();

  Future<List<ActorDAO>> getAllActors(idMovie) async{
    //Hacer referencia al http, ocupar el get, y pide la url. Retorna future response, y al ser future debe ir con await
    final response = await http.get(URL_CAST+'$idMovie/credits?api_key=44051d6ce6b294917358f53d5333496c');
    if(response.statusCode==200){ //Si la peticion fue correcta
      var actors = jsonDecode(response.body)['cast'] as List; //parsear el cuerpo de la respuesta, el cast, y pasa a lista dinamica
      List<ActorDAO> listActors =actors.map((element) => ActorDAO.fromJSON(element)).toList();
      return listActors;
    }else{
      return null;
    }
  }
}