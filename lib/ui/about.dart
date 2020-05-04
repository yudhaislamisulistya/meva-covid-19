import 'package:flutter/material.dart';
import 'package:meva_covid_19/ui/animation/fade_animation.dart';
import 'package:meva_covid_19/ui/developers.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Color.fromRGBO(243, 245, 248, 1),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: new ListView(
          children: <Widget>[
            new SizedBox(
              height: 5,
            ),
            Text(
              "Daftar Nomor Penting",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                  color: Colors.black),
            ),
            new SizedBox(
              height: 5,
            ),
            new Divider(),
            new FadeAnimation(
              0.3,
              Container(
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
                        child: new Icon(
                          Icons.call,
                          color: Colors.lightGreen,
                        ),
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
                            "119",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[900]),
                          ),
                          Text(
                            "Call Center - Pertanyaan Umum",
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
              ),
            ),
            new SizedBox(
              height: 5,
            ),
            new FadeAnimation(
              0.6,
              Container(
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
                        child: new Icon(
                          Icons.call,
                          color: Colors.lightGreen,
                        ),
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
                            "0811 494 119",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[900]),
                          ),
                          Text(
                            "PSC - Pertanyaan Umum",
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
              ),
            ),
            new SizedBox(
              height: 5,
            ),
            Text(
              "Lainnya",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                  color: Colors.black),
            ),
            new SizedBox(
              height: 5,
            ),
            new Divider(),
            new FadeAnimation(
              0.9,
              new GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (BuildContext context) {
                        return new Developers();
                      },
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius:
                                BorderRadius.all(Radius.circular(18))),
                        child: new Container(
                          width: 40,
                          height: 40,
                          child: new Icon(
                            Icons.info_outline,
                            color: Colors.lightGreen,
                          ),
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
                              "Informasi Pengembang",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[900]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
