import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:meva_covid_19/ui/about.dart';
import 'package:meva_covid_19/ui/dashboard.dart';
import 'package:meva_covid_19/ui/hospital.dart';

void main() {
  runApp(new MaterialApp(
    title: "Meva Covid-19",
    home: new Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  int _page = 1;
  GlobalKey _bottomNavigationKey = GlobalKey();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Meva Covid-19"),
        backgroundColor: Color(0xff0f4c81),
        elevation: 0,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 1,
        height: 50.0,
        items: <Widget>[
          Icon(
            Icons.location_city,
            size: 30,
            color: Color.fromRGBO(243, 245, 248, 1),
          ),
          Icon(
            Icons.home,
            size: 30,
            color: Color.fromRGBO(243, 245, 248, 1),
          ),
          Icon(
            Icons.info,
            size: 30,
            color: Color.fromRGBO(243, 245, 248, 1),
          ),
        ],
        color: Color(0xff0f4c81),
        buttonBackgroundColor: Color(0xff0f4c81),
        backgroundColor: Color.fromRGBO(243, 245, 248, 1),
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: _buildContainer(),
    );
  }

  Widget _buildContainer() {
    if (_page == 0) {
      return new Hospital();
    } else if (_page == 1) {
      return new Dashboard();
    } else if (_page == 2) {
      return new About();
    }
  }
}
