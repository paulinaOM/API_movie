import 'package:flutter/material.dart';
import 'package:practica2_2021/src/screens/contact_screen.dart';
import 'package:practica2_2021/src/screens/dashboard.dart';
import 'package:practica2_2021/src/screens/detail_screen.dart';
import 'package:practica2_2021/src/screens/favorite_screen.dart';
import 'package:practica2_2021/src/screens/popular_screen.dart';
import 'package:practica2_2021/src/screens/profile_page.dart';
import 'package:practica2_2021/src/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      title: 'Movies API',
      routes: {
        '/dashboard': (BuildContext context) => Dashboard(),
        '/popular': (BuildContext context) => PopularScreen(),
        '/detail': (BuildContext context) => DetailScreen(),
        '/profile': (BuildContext context) => ProfilePage(),
        '/favorites': (BuildContext context) => FavoriteScreen(),
        '/contact': (BuildContext context) => ContactScreen(),
      },
      home: SplashScreenApp(), //la pantalla principal es splash screen
    );
  }
}

ThemeData themeApp(){
  return ThemeData(
    primaryColor: Color(0xFFCC2948),
    hintColor: Colors.white12,
    scaffoldBackgroundColor: Colors.black87,
    inputDecorationTheme: InputDecorationTheme(
      //floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: TextStyle(color: Color(0xFFCC2948)),
      contentPadding: EdgeInsets.symmetric(horizontal: 40),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFCC2948))
      ),
    ),
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(color: Colors.white70),
      color: Colors.black12,
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.white, fontSize: 16,),
      ),
      elevation: 0,
      brightness: Brightness.light,
    )
  );
}

class AppTheme {
  //AppTheme._();

  // Light Theme
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
      color: Colors.grey[100],
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.white,
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    accentColor: Color(0xFFCC2948),
    primaryColor: Color(0xFFCC2948),
    hintColor: Colors.white12, //placeholder
    scaffoldBackgroundColor: Colors.black87,
    inputDecorationTheme: InputDecorationTheme(
      //floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: TextStyle(color: Color(0xFFCC2948)),
      contentPadding: EdgeInsets.symmetric(horizontal: 40),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFCC2948))
      ),
    ),
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(color: Colors.white70),
      color: Colors.black12,
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.white, fontSize: 16,),
      ),
      elevation: 0,
      brightness: Brightness.light,
    )
  );
}