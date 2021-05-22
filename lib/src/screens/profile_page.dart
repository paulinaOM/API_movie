import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practica2_2021/src/database/database_helper.dart';
import 'package:practica2_2021/src/models/userdao.dart';
import 'package:practica2_2021/src/screens/dashboard.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //Para recuperar los datos de cajas de texto
  TextEditingController txtNombre = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtTelefono = TextEditingController();

  DatabaseHelper _database;


  final picker = ImagePicker();
  String imagePath = "";

  @override
  void initState() { 
    super.initState();
    _database = DatabaseHelper();
  }

  
  @override
  Widget build(BuildContext context) {
    
    
    final imgFinal = imagePath == ""
      ? CircleAvatar(radius: 50, backgroundImage: NetworkImage('https://assets.stickpng.com/images/585e4beacb11b227491c3399.png'))
      : ClipOval(
        child: Image.file(
          File(imagePath),
          fit: BoxFit.cover,
          height: 100,
          width: 100,
        ),
      );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text('Perfil',),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          //Portada, Formulario datos usuario, Boton guardar.
          Column(
            children: <Widget>[
              //Imagen portada
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFCC2948),
                    image: DecorationImage(
                      image: NetworkImage('https://3.bp.blogspot.com/-ORppNE4nAlw/WCDg2Txm5LI/AAAAAAAAAkI/uCqlhAxspK0p6Aa0BetEqv_Zj1Jz80Q0ACLcB/s1600/flores%2Bde%2Bcerezo.jpg'), //https://64.media.tumblr.com/2345963bf707239b676009c35fc3d5c9/tumblr_mi2jkwOmPC1rov2j3o1_500.png
                      fit: BoxFit.fill
                    )
                  )
                ),
              ),
              //Formulario Datos Usuario
              Expanded(
                child: Column(children: [
                  Form(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: TextFormField(
                              controller: txtNombre,
                              decoration: InputDecoration(
                                labelText: 'Nombre',
                                hintText: 'Ingresa tu nombre',
                                prefixIcon: Icon(Icons.person_sharp,),
                              )
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: TextFormField(
                              controller: txtEmail,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                hintText: 'Ingresa tu email',
                                prefixIcon: Icon(Icons.email),
                              )
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: TextFormField(
                              controller: txtTelefono,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Teléfono',
                                hintText: 'Ingresa tu teléfono',
                                prefixIcon: Icon(Icons.phone_android),
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],),
              ),
              //Boton Guardar
              Padding(
                padding: const EdgeInsets.all(15),
                child: RaisedButton(
                  color: Color(0xFFCC2948), //Colors.transparent
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      //side: BorderSide(color: Color(0xFFCC2948))
                  ),
                  onPressed: () {
                    //Realizar validacion  de imagePath
                    UserDAO objUser = UserDAO(
                      nomusr: txtNombre.text,
                      mailusr: txtEmail.text,
                      telusr: txtTelefono.text,
                      fotousr: imagePath
                    );
                    _database.insert('tbl_perfil',objUser.toJSON());
                    Navigator.pushAndRemoveUntil(
                      context, 
                      MaterialPageRoute(builder: (BuildContext context)=> Dashboard()), 
                      ModalRoute.withName('/login')
                    );
                  },
                  padding: EdgeInsets.all(10.0),
                  textColor: Colors.white,
                  child: Container(
                    width: double.infinity,
                    height: 30.0,
                    alignment: Alignment.center,
                    child: Text(
                      "Guardar", 
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Imagen de perfil
          Positioned(
            top: 150.0, 
            child: Stack(
              overflow: Overflow.visible,
              children: [
                imgFinal,
                Positioned(
                  bottom: 0,
                  right: -10,
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Colors.white),
                      ),
                      child: Icon(Icons.camera_alt_outlined, color: Colors.white54,),
                      color: Color(0xFFCC2948),  
                      onPressed: () async{
                        final file = await picker.getImage(source: ImageSource.camera); //getImage es de tipo Future, colocar async y await
                        if(file!=null){
                          imagePath = file.path;
                          String msj = "IMAGE PATH $imagePath";
                          print(msj);
                          setState(() {});
                        }
                      }, 
                    ),
                  ),
                )
              ]
            ),
          )
        ],
      ),
    );
  }
}