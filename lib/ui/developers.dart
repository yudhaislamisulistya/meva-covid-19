import 'package:flutter/material.dart';

class Developers extends StatefulWidget {
  @override
  _DevelopersState createState() => _DevelopersState();
}

class _DevelopersState extends State<Developers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Meva Covid-19"),
        backgroundColor: Color(0xff0f4c81),
        elevation: 0,
      ),
      body: new Container(
        color: Color.fromRGBO(243, 245, 248, 1),
        child: new Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: new ListView(
            children: <Widget>[
              _buildListTim("assets/images/lakilaki.png", "Lea Devs",
                  "Commercial Developer Tim"),
              new Divider(),
              _buildListTim("assets/images/lakilaki.png",
                  "Yudha Islami Sulistya", "Developer"),
              new SizedBox(
                height: 5,
              ),
              _buildListTim(
                  "assets/images/wanita.png", "Sakinah Ahmad", "Member"),
              new SizedBox(
                height: 5,
              ),
              _buildListTim(
                  "assets/images/lakilaki.png", "Satura Daffa", "Member"),
              new SizedBox(
                height: 5,
              ),
              _buildListTim("assets/images/wanita.png",
                  "Indriyani K. Idris Djawasa", "Member"),
              new SizedBox(
                height: 5,
              ),
              _buildListTim("assets/images/wanita.png", "Deva Ranti", "Member"),
              new SizedBox(
                height: 5,
              ),
              _buildListTim("assets/images/lakilaki.png",
                  "Abdul Rahman Lamatoro", "Member"),
              new SizedBox(
                height: 5,
              ),
              _buildListTim(
                  "assets/images/wanita.png", "Magfira Malongi", "Member"),
              new SizedBox(
                height: 5,
              ),
              _buildListTim(
                  "assets/images/wanita.png", "Nurtiansy Syam", "Member"),
              new SizedBox(
                height: 5,
              ),
              _buildListTim(
                  "assets/images/wanita.png", "Rahma Maloto", "Member"),
              new SizedBox(
                height: 5,
              ),
              _buildListTim(
                  "assets/images/lakilaki.png", "Reza Podungge", "Member"),
              new SizedBox(
                height: 5,
              ),
              _buildListTim(
                  "assets/images/wanita.png", "Viona Melkis", "Member"),
              new SizedBox(
                height: 5,
              ),
              _buildListTim("assets/images/lakilaki.png", "Kahfi", "Member"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTim(icon, title, desc) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.all(Radius.circular(18))),
            child: new Container(
              width: 40,
              height: 40,
              child: new Image.asset(icon),
            ),
            padding: EdgeInsets.all(12),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[900]),
                ),
                Text(
                  desc,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[500]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
