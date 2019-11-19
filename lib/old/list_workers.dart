import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:hiremi_flutter/Jobpage.dart';



class list_workers extends StatelessWidget{

  list_workers(this.result);
  var result;

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
      body: ListViewClickListener(result),
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
  const ListViewClickListener(this.result );

  final String result;

  _ListViewClickListenerState createState() => _ListViewClickListenerState();
}

class _ListViewClickListenerState extends State<ListViewClickListener> {
  static TextEditingController result = new TextEditingController();

  static List data = [];

   Future<List> getData() async {

    final username = 'username';
    final password = 'password';
    final credentials = '$username:$password';
    final stringToBase64 = utf8.fuse(base64);
    final encodedCredentials = stringToBase64.encode(credentials);

    var url = "http://calico.palisadoes.org:8081/@search?SearchableText="+result.text;

    List temp_list = [];

    final response = await http.get(url, headers: {
      "Accept": "application/json",
      "Authorization": 'Basic ${encodedCredentials}',
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var temp = json.decode(response.body);
      print(temp);
      //print(temp["items"][0]["@id"]);
      //print(temp["items"][1]);
      for(int a = 0; a < temp["items_total"] ; a++){
        //print(temp["items"][a]["@type"]);
        if(temp["items"][a]["@type"] == 'skillworker') {
          var url = temp["items"][a]["@id"];
          var response2 = await http.get(url, headers: {
            "Accept": "application/json",
            "Authorization": 'Basic ${encodedCredentials}',
          });
          var temp2 = json.decode(response2.body);
          // print(temp2);
          temp_list.add(temp2);
        }
      }
      //print(temp_list[0]["first_name"]);
      setState(() {
        data = temp_list;
        //print(result.text);
      });
      return temp_list;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }



  }



  @override
  void initState() {
    result.text= widget.result;
    //getData();
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


  @override
  Widget build(BuildContext context) {

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

    final futurebuilder = FutureBuilder<List>(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return listbuilder;
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );


    //getData();
    //print(_data.length);
    return Scaffold(
      body: listbuilder,
    );
  }
}

