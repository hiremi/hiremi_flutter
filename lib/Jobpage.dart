import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:hiremi_flutter/main_menu.dart';
import 'package:hiremi_flutter/models.dart';
import 'package:hiremi_flutter/profile_colors.dart';
import 'package:hiremi_flutter/profile_icons.dart';
import 'package:hiremi_flutter/profile_header.dart';
import 'package:hiremi_flutter/quick_actions.dart';
import 'package:carousel_pro/carousel_pro.dart';


class JobPage extends StatelessWidget {
  JobPage(this.data);
  var data;
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Profile',
        home: new ProfileHomePage(data)
    );
  }
}

class ProfileHomePage extends StatelessWidget {
  ProfileHomePage(this.data2);
   var data2;
  @override
  Widget build(BuildContext context) {
    final iconColor = new Color(0xFF2194f3);
    final profile = getProfile();

    return new Scaffold(
      body: new ListView(
        padding: const EdgeInsets.all(0.0),
        children: <Widget>[
          new ProfileHeader(profile,data2),
          SizedBox(
              height: 200.0,
              width: 300.0,
              child: Carousel(
                images: [
                  NetworkImage('https://vaalpaintingandwaterproofing.co.za/wp-content/uploads/2018/07/plumbing-works.jpg'),
                  NetworkImage('https://images2.jiji.ng/20534547_1535141139786_620x827.jpg'),
                  NetworkImage('http://www.bergeqatar.net/images/services/plumbing.jpg'),
                ],
              )
          ),
          new MainMenu(),
        ],
      ),
    );
  }

}

