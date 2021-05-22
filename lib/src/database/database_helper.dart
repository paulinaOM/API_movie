import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:practica2_2021/src/models/populardao.dart';
import 'package:practica2_2021/src/models/userdao.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _nombreBD = "MOVIESDB";
  static final _versionDB = 1;

  static Database _database;

  Future<Database> get database async{
    if(_database != null) 
      return _database; //Si ya está apuntando a algo, retornar, sino, inicializar
    else{
      _database = await _initDatabase(); //Apertura de la bd
      return _database;
    }
  }

  _initDatabase() async{
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaDB = join(carpeta.path, _nombreBD);
    return await openDatabase(
      rutaDB,
      version: _versionDB,
      onCreate: _scriptDB,//Cuando se instala por primera vez la aplicacion
    );
  }

  _scriptDB(Database db, int version) async{
    String script1 =
    "CREATE TABLE tbl_perfil("+
      "id INTEGER PRIMARY KEY,"+
      "nomusr VARCHAR(25),"+ 
      "telusr CHAR(10),"+
      "mailusr VARCHAR(40),"+
      "fotousr VARCHAR(200));";
    String script2 =
    "CREATE TABLE tbl_favorites("+
      "id integer primary key,"+
      "backdrop_path varchar(100),"+
      "original_language varchar(10),"+
      "overview varchar(800),"+
      "popularity decimal(10,2),"+
      "poster_path varchar(200),"+
      "release_date varchar(11),"+
      "title varchar(50),"+
      "vote_average decimal(10,2),"+
      "vote_count integer);";
      
    db.execute(script1);
    db.execute(script2);
  }

  Future<int> insert(String table, Map<String, dynamic> values) async{ //int: Cuántas filas se afectaron
    var conexion = await database;
    return await conexion.insert(table, values);
  }

  Future<int> update(String table, Map<String, dynamic> values, ) async{ //int: Cuántas filas se afectaron
    var conexion = await database;
    return await conexion.update(table, values, where: "id = ?", whereArgs: [values['id']]);
  }

  Future<int> delete(String table, int id) async{ //int: Cuántas filas se afectaron
    var conexion = await database;
    return await conexion.delete(table, where: "id = ?", whereArgs: [id]);
  }

  Future<UserDAO> getUser(String emailUser) async{ //Recuperar el usuario 
    var conexion = await database;
    var result = await conexion.query('tbl_perfil', where: "mailusr = ?", whereArgs: [emailUser]); //Por cada elemento de result se convierte a mapa
    var lista =(result).map((user) => UserDAO.fromJSON(user)).toList();
    return (lista.length>0)? lista[0]: null;
  }

  Future<PopularDAO> getFavMovie(int movieId) async{ //Recuperar pelicula favorita 
    var conexion = await database;
    var result = await conexion.query('tbl_favorites', where: "id = ?", whereArgs: [movieId]); 
    var lista =(result).map((movie) => PopularDAO.fromJSON(movie)).toList();
    return (lista.length>0)? lista[0]: null;
  }

  Future<List<PopularDAO>> getAllFavMovies() async{ //Recuperar pelicula favorita 
    var conexion = await database;
    var result = await conexion.query('tbl_favorites'); 
    var lista =(result).map((movie) => PopularDAO.fromJSON(movie)).toList();
    return (lista.length>0)? lista: null;
  }
}