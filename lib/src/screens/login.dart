import 'package:flutter/material.dart';
class Login extends StatefulWidget{
  Login({Key key}) : super(key:key);
  @override
  _LoginState createState()=>_LoginState();
}

class _LoginState extends State<Login>{
  @override
  Widget build(BuildContext context){
  var emailController=TextEditingController();
  var pwdController=TextEditingController();
  final popcorn= Image.asset('assets/palomitas.png',width: 250,height: 120,); //assets/palomitas.png

  final txtEmail=TextFormField(
    controller: emailController,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      hintText: 'Introduce el email',//placeholder
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),//que se vea la región que ocupa la caja de texto
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFCC2948)),
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal:20, vertical:5),
    ),
  );
  final txtPwd=TextFormField(
    controller: pwdController,
    keyboardType: TextInputType.text,
    obscureText: true,
    decoration: InputDecoration(
      hintText: 'Introduce el password',//placeholder
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),//que se vea la región que ocupa la caja de texto
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFCC2948)),
        borderRadius: BorderRadius.circular(10),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal:20, vertical:5),
    ),
  );

  final loginButton = RaisedButton(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)
    ),
    child: Text('Validar Usuario', style: TextStyle(color:Colors.white),),
    color: Color(0xFFCC2948),
    onPressed:(){
        //validar usuario mediante API
        //Dos formas de llamar al dashboard
        //1. mete una pantalla mediante un alias
        Navigator.pushNamed(context,'/dashboard');
        //2. Segunda forma
        //Navigator.push(context, MaterialPageRoute(builder:(context)=> Dashboard()));
    }
  );
  
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/fondo2.webp'), //assets/fondo1.jpg
              fit: BoxFit.fill
            )
          ),
        ),
        Card(
          color: Colors.black,
          elevation: 10.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,//se ajusta al contenido que tiene
              children: [
                //cajas de texto que conforma el formulario de captura
                txtEmail,
                SizedBox(height:10,),//espacio entre los dos campos
                txtPwd,
                SizedBox(height:10,),//espacio entre los dos campos
                loginButton
              ],
            ),
          ),
        ),
        Positioned(
          child: popcorn,
          bottom: 140,
          )
      ],
    );
  }
}