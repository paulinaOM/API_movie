import 'package:flutter/material.dart';
import 'package:practica2_2021/src/screens/login.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenApp extends StatefulWidget {
  SplashScreenApp({Key key}) : super(key: key);

  @override
  _SplashScreenAppState createState() => _SplashScreenAppState();
}

class _SplashScreenAppState extends State<SplashScreenApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: Login(), //hacia donde vas a navegar
      title: Text('Bienvenidos'),
      image: Image.asset('assets/palomitas.png', width: 600, height: 400,), //Diferencia entre Image.network y NetworkImage
      gradientBackground: LinearGradient(
        begin: Alignment.topCenter, //Donde empieza el gradiente
        end: Alignment.bottomCenter, //Donde termina el gradiente
        colors: [Colors.blueAccent, Colors.lightBlueAccent]
      ),
      loaderColor: Colors.indigo[900],
    );
  }
}