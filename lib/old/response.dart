import 'package:flutter/material.dart';

class MyApp4 extends StatelessWidget {
 List<String> data;

  MyApp4({Key key, this.data}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    print(data[0]);
    Widget titleSection = Container(
  padding: const EdgeInsets.all(32),
  child: Row(
    children: [
      Expanded(
        /*1*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*2*/
            Container(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                data[0],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              data[2],
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
      /*3*/
      Icon(
        Icons.star,
        color: Colors.red[500],
      ),
      Text('41'),
    ],
  ),
);
   Color color = new Color(0xFF1A237E);

Widget buttonSection = Container(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildButtonColumn(color, Icons.call, 'CALL'),
      _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
      _buildButtonColumn(color, Icons.share, 'SHARE'),
    ],
  ),
);
Widget textSection = Container(
  padding: const EdgeInsets.all(32),
  child: Text(data[0]
      +"\n"+data[2]
      +"\n"+data[4]
      +"\n"+data[5]
      +"\n"+data[6],
    softWrap: true,
  ),
);  
    return MaterialApp(
      title: data[0],
      home: Scaffold(
        appBar: AppBar(
          title: Text('Devca'),
          backgroundColor: Color(0xFF1A237E),
        ),
       body: ListView(            
                 children: [
                   Image.network(data[3],
                   width: 600,
                   height: 240,
                   fit: BoxFit.cover,
                   ),            
                  titleSection,
                  buttonSection,
                  textSection,            
       ],
      ),
    ),);
  }
 Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
 }
}
