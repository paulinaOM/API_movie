import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:practica2_2021/src/models/backdropdao.dart';
import 'package:practica2_2021/src/models/populardao.dart';
import 'package:practica2_2021/src/models/videodao.dart';

class ApiPopular{
  final URL_POPULAR = "https://api.themoviedb.org/3/movie/popular?api_key=44051d6ce6b294917358f53d5333496c";
  final URL_VIDEO_TRAILER = "https://api.themoviedb.org/3/movie/";
  Client http = Client();

  Future<List<PopularDAO>> getAllPopular() async{
    //Hacer referencia al http, ocupar el get, y pide la url. Retorna future response, y al ser future debe ir con await
    final response = await http.get(URL_POPULAR);
    if(response.statusCode==200){ //Si la peticion fue correcta
      var popular = jsonDecode(response.body)['results'] as List; //parsear el cuerpo de la respuesta, el results, y pasa a lista dinamica
      List<PopularDAO> listPopular =popular.map((element) => PopularDAO.fromJSON(element)).toList();
      return listPopular;
    }else{
      return null;
    }
  }

  Future<List<VideoDAO>> getVideoKey(int idMovie) async{
    final response = await http.get(URL_VIDEO_TRAILER+'${idMovie.toString()}/videos?api_key=44051d6ce6b294917358f53d5333496c&language=en-US');
    if(response.statusCode==200){
      var videos = jsonDecode(response.body)['results'] as List; //parsear el cuerpo de la respuesta, el results, y pasa a lista dinamica
      List<VideoDAO> listVideos =videos.map((element) => VideoDAO.fromJSON(element)).toList();
      return listVideos;
    }else{
      return null;
    }
  }

  Future<List<BackdropImageDAO>> getMovieImages(int idMovie) async{
    final response = await http.get(URL_VIDEO_TRAILER+'${idMovie.toString()}/images?api_key=44051d6ce6b294917358f53d5333496c');
    if(response.statusCode==200){
      var images = jsonDecode(response.body)['backdrops'] as List; //parsear el cuerpo de la respuesta, el results, y pasa a lista dinamica
      List<BackdropImageDAO> listImages =images.map((element) => BackdropImageDAO.fromJSON(element)).toList();
      return listImages;
    }else{
      return null;
    }
  }
}