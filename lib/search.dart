import 'package:flutter/material.dart';
import 'package:hiremi_flutter/list_workers.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:math';


class Search extends StatefulWidget{
  @override
 _Search createState() => _Search();
}

class _Search extends State<Search>{

  @override
  Widget build(BuildContext context) {
    final searchField = TextField(
      obscureText: false,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "eg. Plumber Electrician"),

    );

    final searchButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){return (list_workers());
          }));},
        child: Text("Get Assistance",
            textAlign: TextAlign.center),
      ),
    );
    
    
    return Scaffold(
      appBar: AppBar(title: Text("FInd a Skilled a worker"),),
      drawer: Drawer(child: drawer(context),),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("What type of worker are you looking for?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25),),
                SizedBox(
                  height: 35.0,
                ),
                searchField,
                SizedBox(
                  height: 35.0,
                ),
                searchButon,
                SizedBox(
                  height: 35.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget drawer(context ){
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text('HireMI',
              style: TextStyle(
                  color: Colors.white,
                  //fontWeight: FontWeight.bold,
                  fontSize: 24.0)
          ),
          decoration: BoxDecoration(
            color:Color(0xFF1A237E),
          ),
        ),
        ListTile(
          title: Text('Settings'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text('Exit'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

