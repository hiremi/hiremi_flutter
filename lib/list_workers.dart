import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:hiremi_flutter/Jobpage.dart';


class list_workers extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HireMI'),
        actions: <Widget>[
          Text("Current Workers",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          )
        ],
        backgroundColor: Color(0xFF8bc35e),
      ),
      body: ListViewClickListener(),
      drawer: Drawer(child: drawer(context),),
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
            color:Color(0xFF8bc35e),
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

class ListViewClickListener extends StatefulWidget {
  _ListViewClickListenerState createState() => _ListViewClickListenerState();
}

class _ListViewClickListenerState extends State<ListViewClickListener> {

  List<List<String>> _data = new List<List<String>>();

  static final username = 'username';
  static final password = 'password';
  static final credentials = '$username:$password';
  static final stringToBase64 = utf8.fuse(base64);
  final encodedCredentials = stringToBase64.encode(credentials);

  static List data = [];
  List temp_list = [];

  Future<String> getData() async {
    var response = await http.get(
        "http://calico.palisadoes.org:8081/users", headers: {
      "Accept": "application/json",
      "Authorization": 'Basic ${encodedCredentials}',
    });

    print(response.statusCode);
    var temp = json.decode(response.body);
    //print(temp["items"][1]);
    for(int a = 0; a < temp["items"].length ; a++){
      var url  = temp["items"][a]["@id"];
      var response2 = await http.get(url, headers: {
        "Accept": "application/json",
        "Authorization": 'Basic ${encodedCredentials}',
      });
      var temp2 = json.decode(response2.body);
     // print(temp2);
      temp_list.add(temp2);

    }
    print(temp_list[1]["first_name"]);
    setState(() {
      data = temp_list;
    });
  }



  @override
  void initState() {
    getData();
    //print(_demoData.length);

    // This is the proper place to make the async calls
    // This way they only get called once

    // During development, if you change this code,
    // you will need to do a full restart instead of just a hot reload

    // // You can't use async/await here,
    // // We can't mark this method as async because of the @override
    // loadAsyncData().then((result) {
    //     // If we need to rebuild the widget with the resulting data,
    //     // make sure to use `setState`
    //     setState(() {
    //         _result = result;
    //     });
    // });
  }

  final listbuilder = ListView.builder(
    itemCount: data.length,
    itemBuilder: (context, index) {
      return Card(
        child: ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){return JobPage(data[index]);
            }));},
          leading: Image.network(data[index]["profile_picture"]["download"]),
          title: Text(data[index]["first_name"]+" "+data[index]["lastname"]),
          subtitle: Column(
            children: <Widget>[
              Text('Skills: '+data[index]["skill"]["title"]+' | phone#: '+ data[index]["phone_number"].toString()+' \n Email: '+data[index]["email_address"]),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(4, (index2) {
                  return Icon(
                    index < data[index]["rating"] ? Icons.star : Icons.star_border,
                  );
                }),
              )

            ],
          ),
          isThreeLine: true,
        ),
      );
    },
  );


  @override
  Widget build(BuildContext context) {
    //getData();
    //print(_data.length);
    return Scaffold(
      body: listbuilder,
    );
  }
}

