import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_boom_menu/flutter_boom_menu.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  ContactScreen({Key key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();
    
    CameraPosition _myPosition = CameraPosition(
      target: LatLng(20.5417018,-100.8130878),
      zoom: 25.0
    );

    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _myPosition,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        }
      ),
      floatingActionButton: _buildBoomMenu(),
    );
  }

  _buildBoomMenu() {
    return BoomMenu(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 20),
      overlayColor: Colors.black,
      overlayOpacity: 0.7,
      children: [
        MenuItem(
          title: 'Email',
          child: Icon(Icons.mail, color: Colors.grey[850],),
          subtitle: 'ana_mm@gmail.com',
          subTitleColor: Colors.grey[850],
          backgroundColor: Colors.blue[50],
          onTap: () => _sendEmail(),
        ),
        MenuItem(
          title: 'Phone number',
          child: Icon(Icons.phone, color: Colors.grey[850]),
          subtitle: '4611500245',
          subTitleColor: Colors.grey[850],
          backgroundColor: Colors.blue[50],
          onTap: () => _callPhone(),
        ),
        MenuItem(
          title: 'Message',
          child: Icon(Icons.message, color: Colors.grey[850]),
          subtitle: '4611500245',
          subTitleColor: Colors.grey[850],
          backgroundColor: Colors.blue[50],
          onTap: () => _sendMessage(),
        ),
      ],
    );
  }

  _callPhone() async{
    const tel = 'tel:4611500245'; //Para parsear es necesario anteponer tel:
    if(await canLaunch(tel)){ //Verificar que se puede intentar 'parsear'
      await launch(tel);
    }
  }

  _sendEmail() async{
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'otero.martinez.paulina.1f@gmail.com',  //A quien se envia
      query: 'subject=Enviando email&body=Hola desde mi app'
    );

    var email = params.toString();

    if(await canLaunch(email)){
      await launch(email);
    }
  }

  _sendMessage() async{
    const tel = 'sms:4611500245';
    if(await canLaunch(tel)){
      await launch(tel);
    }
  }
}