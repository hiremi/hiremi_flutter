import 'package:flutter/material.dart';
import 'package:hiremi_flutter/profile_colors.dart';
import 'package:hiremi_flutter/profile_fonts.dart';
import 'package:hiremi_flutter/profile_icons.dart';
import 'package:hiremi_flutter/models.dart';
import 'dart:math';

class ProfileHeader extends StatelessWidget {

  final Profile profile;

  ProfileHeader(this.profile ,this.data);
  var data;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery
        .of(context)
        .padding
        .top;

    final headerGradient = new RadialGradient(
      center: Alignment.topLeft,
      radius: 0.4,
      colors: <Color>[
        const Color(0xFF8bc35e),
        const Color(0xFF8bc35e),
      ],
      stops: <double>[
        0.4, 1.0,
      ],
      tileMode: TileMode.repeated,
    );

    const headerHeight = 290.0;

    return new Container(
      height: headerHeight,
      decoration: new BoxDecoration(
        color: ProfileColors.primaryColor,
        boxShadow: <BoxShadow>[
          new BoxShadow(spreadRadius: 2.0,
              blurRadius: 4.0,
              offset: new Offset(0.0, 1.0),
              color: Colors.black38),
        ],
      ),
      child: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // linear gradient
          new Container(
            height: headerHeight,
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                  colors: <Color>[ //7928D1
                    const Color(0xFF8bc35e), const Color(0xFF8bc35e)],
                  stops: <double>[0.3, 0.5],
                  begin: Alignment.topRight, end: Alignment.bottomLeft
              ),
            ),
          ),
          // radial gradient
          new CustomPaint(
            painter: new HeaderGradientPainter(),
          ),
          new Padding(
            padding: new EdgeInsets.only(
                top: topPadding, left: 15.0, right: 15.0, bottom: 20.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildBellIcon(),
                new Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: _buildTitle(),
                ),
                new Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: _buildAvatar(),
                ),
                _buildFollowerStats()
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build the bell icon at the top right corner of the header
  Widget _buildBellIcon() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new IconButton(
            icon: new Icon(
              Icons.monetization_on, color: Colors.white, size: 40.0,),
            onPressed: () {}),
      ],
    );
  }

  Widget _buildTitle() {
    return new Text(data["skill"]["title"],
        style: new TextStyle(
            fontFamily: ProfileFontNames.TimeBurner,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            fontSize: 40.0,
            letterSpacing: 1.0));
  }

  /// The avatar consists of the profile image, the users name and location
  Widget _buildAvatar() {
    final mainTextStyle = new TextStyle(fontFamily: ProfileFontNames.TimeBurner,
        color: Colors.white,
        fontWeight: FontWeight.w700,
        fontSize: 20.0);
    final subTextStyle = new TextStyle(
        fontFamily: ProfileFontNames.TimeBurner,
        fontSize: 16.0,
        color: Colors.white70,
        fontWeight: FontWeight.w700);

    return new Row(
      children: <Widget>[
        new Container(
          width: 70.0, height: 60.0,
          decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new NetworkImage(data["profile_picture"]["download"]),
                fit: BoxFit.cover),
            borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
            boxShadow: <BoxShadow>[
              new BoxShadow(
                  color: Colors.black26, blurRadius: 5.0, spreadRadius: 1.0),
            ],
          ),
        ),
        new Padding(padding: const EdgeInsets.only(right: 20.0)),
        Column(
//          direction: Axis.horizontal,
//          spacing: 10,
//          runSpacing: 10,
//          alignment: WrapAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(data["first_name"]+" "+data["lastname"], style: mainTextStyle),
            Text(data["description"], style: subTextStyle),
          ],
        ),
      ],
    );
  }

  Widget _buildFollowerStats() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildFollowerStat("Phone#", data["phone_number"].toString()),
        _buildVerticalDivider(),
        _buildFollowerStat("Email", data["email_address"]),
        _buildVerticalDivider(),
      ],
    );
  }

  Widget _buildFollowerStat(String title, String value) {
    final titleStyle = new TextStyle(
        fontSize: 16.0,
        fontFamily: ProfileFontNames.TimeBurner,
        color: Colors.white);
    final valueStyle = new TextStyle(
        fontFamily: ProfileFontNames.TimeBurner,
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: Colors.white);
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Text(title, style: titleStyle),
        new Text(value, style: valueStyle),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return new Container(
      height: 30.0,
      width: 1.0,
      color: Colors.white30,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
    );
  }
}

class HeaderGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: paint background radial gradient
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

}