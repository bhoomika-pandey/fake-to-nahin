import 'dart:io';
import 'package:flutter/material.dart';

class DrawerButton extends StatefulWidget {
  @override
  _DrawerButtonState createState() => _DrawerButtonState();
  
}

class _DrawerButtonState extends State<DrawerButton> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        addRepaintBoundaries: true,
        padding: EdgeInsets.zero,
        children:[
          DrawerHeader(child:Text('Fake To Nahin',style:TextStyle(fontWeight: FontWeight.bold,fontSize:24,color: Colors.white)),decoration: BoxDecoration(color: Colors.lightBlue[800]),),
          ListTile(title: Text('Home',style:TextStyle(color: Colors.lightBlue[800],fontSize: 20)),onTap: (){Navigator.pushNamedAndRemoveUntil(context,'Home',ModalRoute.withName('/'));},),
          ListTile(title: Text('Profile',style:TextStyle(color: Colors.lightBlue[800],fontSize: 20)),onTap: (){Navigator.pushNamed(context,'Profile');},),
          ListTile(title: Text('My Posts',style:TextStyle(color: Colors.lightBlue[800],fontSize: 20)),onTap: (){Navigator.pushNamed(context,'MyPosts');},),
          ListTile(title: Text('Saved Posts',style:TextStyle(color: Colors.lightBlue[800],fontSize: 20)),onTap: (){Navigator.pushNamed(context,'SavedPosts');},),
          ListTile(title: Text('Exit',style:TextStyle(color: Colors.lightBlue[800],fontSize: 20)),onTap:()=>exit(0) )
        ]
      ),
    );
  }
}