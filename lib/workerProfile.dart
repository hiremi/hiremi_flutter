import "package:flutter/material.dart";

class workerProfile extends StatefulWidget{
  @override
  _workerProfile createState() => _workerProfile();
}

class _workerProfile extends State<workerProfile>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(  
                backgroundColor: Colors.brown.shade800,
                child: Image.asset(
                    "assets/logo.png"),

              )
            ],
          ),
        ),
      ),
    );
  }
}