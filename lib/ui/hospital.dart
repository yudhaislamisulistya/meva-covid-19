import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meva_covid_19/ui/animation/fade_animation.dart';
import 'package:url_launcher/url_launcher.dart';

class Hospital extends StatefulWidget {
  @override
  _HospitalState createState() => _HospitalState();
}

class _HospitalState extends State<Hospital> {
  Future<void> _launched;
  final String url = "https://banuacoders.com/api/pico/rumahsakit";
  List data;

  Future<String> getDataHospital() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {'accept': 'application/json'});

    setState(() {
      var content = json.decode(res.body);
      data = content['data'];
      print(data);
    });
    return 'success!';
  }

  @override
  void initState() {
    super.initState();
    this.getDataHospital();
  }

  Future<void> _makePhoneCall(String telp) async {
    if (await canLaunch(telp)) {
      await launch(telp);
    } else {
      throw 'Could not launch $telp';
    }
  }

  Future<void> _launchMapsUrl(double lat, double lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _makeEmail(String email) async {
    if (await canLaunch(email)) {
      await launch(email);
    } else {
      throw 'Could not launch $email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff0f4c81),
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    new FadeAnimation(
                      0.3,
                      new Container(
                        height: 100,
                        width: 100,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: AssetImage("assets/images/hospital.png"),
                          ),
                        ),
                      ),
                    ),
                    new SizedBox(
                      width: 10,
                    ),
                    new Expanded(
                      child: new FadeAnimation(
                        0.9,
                        new Text(
                          "Berikut Ini Adalah Beberapa Daftar Rumah Sakit yang Melayani Bencana Covid-19 di Provinsi Sulawesi Tengah",
                          style: new TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          //draggable sheet
          DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(243, 245, 248, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Rumah Sakit",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 32),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      data == null
                          ? new Center(
                              child: new Column(
                                children: <Widget>[
                                  new CircularProgressIndicator(),
                                  new Text("Menunggu Data"),
                                ],
                              ),
                            )
                          : ListView.builder(
                              itemBuilder: (context, index) {
                                String telepon = data[index]["telepon"];
                                String email = data[index]["email"];
                                double lat =
                                    double.parse(data[index]["latitude"]);
                                double long =
                                    double.parse(data[index]["longitude"]);

                                return new FadeAnimation(
                                  0.9,
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(18),
                                            ),
                                          ),
                                          child: new Container(
                                            width: 50,
                                            height: 50,
                                            decoration: new BoxDecoration(
                                              image: new DecorationImage(
                                                image: AssetImage(
                                                    getImageHospitalByNo(
                                                        data[index]["no"])),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          padding: EdgeInsets.all(12),
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                data[index]["nama"],
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.grey[900]),
                                              ),
                                              Text(
                                                data[index]["alamat"],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.grey[500]),
                                              ),
                                              new Row(
                                                children: <Widget>[
                                                  new SizedBox(
                                                    width: 50,
                                                    child: new MaterialButton(
                                                      onPressed: () {
                                                        _launched =
                                                            _makePhoneCall(
                                                                "tel:$telepon");
                                                      },
                                                      color: Colors.lightGreen,
                                                      child: new Icon(
                                                        Icons.call,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  new SizedBox(
                                                    width: 5,
                                                  ),
                                                  new SizedBox(
                                                    width: 50,
                                                    child: new MaterialButton(
                                                      onPressed: () {
                                                        _launched = _makePhoneCall(
                                                            "mailto:$email?subject=Corona&body=New%20plugin");
                                                      },
                                                      color: Colors.orange,
                                                      child: new Icon(
                                                        Icons.email,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  new SizedBox(
                                                    width: 5,
                                                  ),
                                                  new SizedBox(
                                                    width: 50,
                                                    child: new MaterialButton(
                                                      onPressed: () {
                                                        _launched =
                                                            _launchMapsUrl(
                                                                lat, long);
                                                      },
                                                      color: Colors.blueAccent,
                                                      child: new Icon(
                                                        Icons.directions,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              shrinkWrap: true,
                              itemCount: data.length,
                              padding: EdgeInsets.all(0),
                              controller:
                                  ScrollController(keepScrollOffset: false),
                            ),
                    ],
                  ),
                  controller: scrollController,
                ),
              );
            },
            initialChildSize: 0.8,
            minChildSize: 0.8,
            maxChildSize: 1,
          )
        ],
      ),
    );
  }

  String getImageHospitalByNo(no) {
    String url;
    if (no == 1) {
      url = "assets/images/rsud-undata.jpeg";
    } else if (no == 2) {
      url = "assets/images/rsud-anatapura.jpg";
    } else if (no == 3) {
      url = "assets/images/rsud-luwuk.jpg";
    } else if (no == 4) {
      url = "assets/images/rsud-toli-toli.jpeg";
    } else if (no == 5) {
      url = "assets/images/rsud-kolonedale.jpg";
    }
    return url;
  }
}
