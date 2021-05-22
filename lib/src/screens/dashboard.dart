import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:practica2_2021/src/database/database_helper.dart';
import 'package:practica2_2021/src/models/userdao.dart';
import 'package:practica2_2021/src/utils/configuration.dart';

class Dashboard extends StatelessWidget{
  const Dashboard({Key key}): super(key: key);
  
  @override
  Widget build(BuildContext context) {
    DatabaseHelper _database = DatabaseHelper();

    return Scaffold(
      appBar: AppBar(title: Text('Dashboard'),),
      drawer: FutureBuilder(
        future: _database.getUser('ana_mm@gmail.com'),
        builder: (BuildContext context, AsyncSnapshot<UserDAO> user) {
        return Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  //Centralizar colores
                  color: Configuration.colorheader
                ),
                accountName: Text(user.data == null ? "PRUEBA" : user.data.nomusr), 
                accountEmail: Text(user.data == null ? "PRUEBAMAIL" : user.data.mailusr),
                currentAccountPicture: user.data != null 
                  ? ClipOval(child: Image.file(File(user.data.fotousr), fit: BoxFit.cover, height: 100, width: 100,),)
                  : CircleAvatar(
                  backgroundColor: Color(0xFFCC2948),
                  backgroundImage: AssetImage('assets/perfilpic.jpg'),//NetworkImage('https://assets.stickpng.com/images/585e4beacb11b227491c3399.png'),
                ),
                onDetailsPressed: (){ //Para que al presionar envíe a otra pantalla con los datos del usuario
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              ListTile(//Permite mostrar en pantalla una etiqueta que puede posicionar izquerda o derecha
                leading: Icon(Icons.trending_up, color: Configuration.coloricons,),
                title: Text('Popular'),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/popular');
                },
                trailing: Icon(Icons.chevron_right, color: Configuration.coloricons,),
              ),
              ListTile(//Permite mostrar en pantalla una etiqueta que puede posicionar izquerda o derecha
                leading: Icon(Icons.search, color: Configuration.coloricons,),
                title: Text('Search'),
                onTap: (){
                  Navigator.pop(context);
                  //Navigator.pushNamed(context, '/search');
                },
                trailing: Icon(Icons.chevron_right, color: Configuration.coloricons,),
              ),
              ListTile(//Permite mostrar en pantalla una etiqueta que puede posicionar izquerda o derecha
                leading: Icon(Icons.favorite, color: Configuration.coloricons,),
                title: Text('Favorites'),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/favorites');
                },
                trailing: Icon(Icons.chevron_right, color: Configuration.coloricons,),
              ),
              ListTile(//Permite mostrar en pantalla una etiqueta que puede posicionar izquerda o derecha
                leading: Icon(Icons.person, color: Configuration.coloricons,),
                title: Text('Contact Us'),
                onTap: (){
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/contact');
                },
                trailing: Icon(Icons.chevron_right, color: Configuration.coloricons,),
              )
            ],
            ),
          );
        }
      ),
    );
  }
}