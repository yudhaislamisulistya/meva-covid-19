import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class DetailRegency extends StatefulWidget {
  final int no;
  final dynamic data;
  final dynamic data_covid_world;
  final dynamic data_covid_indonesia;
  final dynamic data_covid_sulteng;
  DetailRegency(
      {this.no,
      this.data,
      this.data_covid_world,
      this.data_covid_sulteng,
      this.data_covid_indonesia});
  @override
  _DetailRegencyState createState() => _DetailRegencyState();
}

class _DetailRegencyState extends State<DetailRegency> {
  final String url_regency = "https://banuacoders.com/api/pico/kabupaten/";

  static dynamic data_regency;

  Future<String> getDataRegency() async {
    var res = await http.get(Uri.encodeFull(url_regency + widget.no.toString()),
        headers: {'accept': 'application/json'});
    setState(() {
      var content = json.decode(res.body);
      data_regency = content['data'];
      print(data_regency);
    });
    return 'success!';
  }

  @override
  void initState() {
    super.initState();
    this.getDataRegency();
  }

  @override
  Widget build(BuildContext context) {
    print("Ini Data Dari Widget");
    print(widget.data);
    var data = [
      ClicksPerYear('ODP', widget.data["ODP"], Colors.yellow),
      ClicksPerYear('PDP', widget.data["PDP"], Colors.amber),
      ClicksPerYear('P', widget.data["positif"], Colors.orange),
      ClicksPerYear('N', widget.data["negatif"], Colors.black),
      ClicksPerYear('M', widget.data["meninggal"], Colors.red),
      ClicksPerYear(
          'DP-1', widget.data["dalam_pemantauan"], Colors.yellowAccent),
      ClicksPerYear(
          'SP-1', widget.data["selesai_pemantauan"], Colors.amberAccent),
      ClicksPerYear(
          'DP-2', widget.data["dalam_pengawasan"], Colors.orangeAccent),
      ClicksPerYear(
          'SP-2', widget.data["selesai_pengawasan"], Colors.redAccent),
    ];

    var series = [
      charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Clicks',
        data: data,
      ),
    ];

    var chart = charts.BarChart(
      series,
      animate: true,
    );

    var chartWidget = Padding(
      padding: EdgeInsets.all(32.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 200.0,
        child: chart,
      ),
    );
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Meva Covid-19"),
        backgroundColor: Color(0xff0f4c81),
        elevation: 0,
      ),
      body: Container(
        color: Color(0xff0f4c81),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            data_regency == null
                ? new Center(
                    child: new Column(
                    children: <Widget>[
                      new SizedBox(
                        height: 100,
                      ),
                      new CircularProgressIndicator(),
                      new Text(
                        "Menunggu Data",
                        style: new TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ))
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              data_regency["kabupaten"],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.white,
                                    child: ClipOval(
                                      child: Image.asset(
                                        getImageRegencyByNo(data_regency["no"]),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(
                          "Sulawesi Tengah",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.blue[100]),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: 55,
                                    height: 55,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(243, 245, 248, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(18))),
                                    child: Center(
                                        child: Text(
                                      data_regency["ODP"].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Colors.yellow),
                                    )),
                                    padding: EdgeInsets.all(12),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "ODP",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Colors.yellow),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: 55,
                                    height: 55,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(243, 245, 248, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(18))),
                                    child: Center(
                                        child: Text(
                                      data_regency["PDP"].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Colors.amber),
                                    )),
                                    padding: EdgeInsets.all(12),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "PDP",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Colors.amber),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: 55,
                                    height: 55,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(243, 245, 248, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(18))),
                                    child: Center(
                                        child: Text(
                                      data_regency["positif"].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Colors.orange),
                                    )),
                                    padding: EdgeInsets.all(12),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Positif",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Colors.orange),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: 55,
                                    height: 55,
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(243, 245, 248, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(18))),
                                    child: Center(
                                        child: Text(
                                      data_regency["meninggal"].toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14,
                                          color: Colors.red),
                                    )),
                                    padding: EdgeInsets.all(12),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Meninggal",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          "Pembaharuan Data Per Tanggal : ${DateTime.parse(data_regency["updated_at"]).toString().split(".").first}",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Colors.lightGreen[100]),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          "Detail",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            children: <Widget>[
                              _buildDataDetailCovid(
                                  "Negatif (N)", data_regency["negatif"]),
                              new Divider(),
                              _buildDataDetailCovid("Dalam Pemantauan (DP-1)",
                                  data_regency["dalam_pemantauan"]),
                              new Divider(),
                              _buildDataDetailCovid("Selesai Pemantauan (SP-1)",
                                  data_regency["selesai_pemantauan"]),
                              new Divider(),
                              _buildDataDetailCovid("Dalam Pengawasan (DP-2)",
                                  data_regency["dalam_pengawasan"]),
                              new Divider(),
                              _buildDataDetailCovid("Selesai Pengawasan (SP-2)",
                                  data_regency["selesai_pengawasan"]),
                            ],
                          ),
                        ),
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
                                "Chart",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 24,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 32),
                        ),
                        data_regency == null
                            ? new Center(
                                child: new Column(
                                children: <Widget>[
                                  new SizedBox(
                                    height: 100,
                                  ),
                                  new CircularProgressIndicator(),
                                  new Text(
                                    "Menunggu Data",
                                    style: new TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ))
                            : chartWidget,
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Lainnya",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 24,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 32),
                        ),
                        widget.data_covid_world == null
                            ? new Center(
                                child: new Column(
                                children: <Widget>[
                                  new SizedBox(
                                    height: 100,
                                  ),
                                  new CircularProgressIndicator(),
                                  new Text(
                                    "Menunggu Data",
                                    style: new TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ))
                            : Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 5),
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        new Text(
                                          "Dunia",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        new SizedBox(
                                          width: 10,
                                        ),
                                        new Image.asset(
                                          "assets/images/dunia.png",
                                          fit: BoxFit.fill,
                                          width: 50,
                                          height: 50,
                                        )
                                      ],
                                    ),
                                    new Divider(),
                                    _buildDataDetailCovid("Kasus",
                                        widget.data_covid_world["cases"]),
                                    new Divider(),
                                    _buildDataDetailCovid("Meninggal",
                                        widget.data_covid_world["deaths"]),
                                    new Divider(),
                                    _buildDataDetailCovid("Sembuh",
                                        widget.data_covid_world["recovered"]),
                                  ],
                                ),
                              ),
                        widget.data_covid_sulteng == null
                            ? new Center(
                                child: new Column(
                                children: <Widget>[
                                  new SizedBox(
                                    height: 100,
                                  ),
                                  new CircularProgressIndicator(),
                                  new Text(
                                    "Menunggu Data",
                                    style: new TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ))
                            : Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 5),
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        new Text(
                                          "Indonesia",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        new SizedBox(
                                          width: 10,
                                        ),
                                        new Image.asset(
                                          "assets/images/indonesia.png",
                                          fit: BoxFit.fill,
                                          width: 50,
                                          height: 50,
                                        )
                                      ],
                                    ),
                                    new Divider(),
                                    _buildDataDetailCovid("Kasus Positif",
                                        widget.data_covid_indonesia["cases"]),
                                    new Divider(),
                                    _buildDataDetailCovid(
                                        "Kasus Positif Hari Ini",
                                        widget.data_covid_indonesia[
                                            "todayCases"]),
                                    new Divider(),
                                    _buildDataDetailCovid("Meninggal",
                                        widget.data_covid_indonesia["deaths"]),
                                    new Divider(),
                                    _buildDataDetailCovid(
                                        "Meninggal Hari Ini",
                                        widget.data_covid_indonesia[
                                            "todayDeaths"]),
                                    new Divider(),
                                    _buildDataDetailCovid(
                                        "Sembuh",
                                        widget
                                            .data_covid_indonesia["recovered"]),
                                    new Divider(),
                                    _buildDataDetailCovid("Aktif Positif",
                                        widget.data_covid_indonesia["active"]),
                                    new Divider(),
                                    _buildDataDetailCovid(
                                        "Total Tes",
                                        widget.data_covid_indonesia[
                                            "totalTests"]),
                                  ],
                                ),
                              ),
                        widget.data_covid_sulteng == null
                            ? new Center(
                                child: new Column(
                                children: <Widget>[
                                  new SizedBox(
                                    height: 100,
                                  ),
                                  new CircularProgressIndicator(),
                                  new Text(
                                    "Menunggu Data",
                                    style: new TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ))
                            : Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 5),
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        new Text(
                                          "Sulawesi Tengah",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        new SizedBox(
                                          width: 10,
                                        ),
                                        new Image.asset(
                                          "assets/images/sulteng.png",
                                          fit: BoxFit.fill,
                                          width: 50,
                                          height: 50,
                                        )
                                      ],
                                    ),
                                    new Divider(),
                                    _buildDataDetailCovid("Positif",
                                        widget.data_covid_sulteng["positif"]),
                                    new Divider(),
                                    _buildDataDetailCovid("Meninggal",
                                        widget.data_covid_sulteng["meninggal"]),
                                    new Divider(),
                                    _buildDataDetailCovid("Sembuh",
                                        widget.data_covid_sulteng["sembuh"]),
                                  ],
                                ),
                              ),
                      ],
                    ),
                    controller: scrollController,
                  ),
                );
              },
              initialChildSize: 0.3,
              minChildSize: 0.3,
              maxChildSize: 1,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDataDetailCovid(title, count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        new Row(
          children: <Widget>[
            new Text(
              getConvertionCurrency(count).output.nonSymbol,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            new SizedBox(
              width: 5,
            ),
            new Text("Orang",
                style: TextStyle(fontSize: 8, fontWeight: FontWeight.w700))
          ],
        )
      ],
    );
  }

  getConvertionCurrency(value) {
    return new FlutterMoneyFormatter(
        amount: value.toDouble(),
        settings: MoneyFormatterSettings(
            symbol: 'IDR',
            thousandSeparator: '.',
            decimalSeparator: ',',
            symbolAndNumberSeparator: ' ',
            fractionDigits: 0));
  }

  String getImageRegencyByNo(no) {
    String url;
    if (no == 1) {
      url = "assets/images/banggai.png";
    } else if (no == 2) {
      url = "assets/images/bengkep.png";
    } else if (no == 3) {
      url = "assets/images/banglaut.png";
    } else if (no == 4) {
      url = "assets/images/buol.png";
    } else if (no == 5) {
      url = "assets/images/donggala.png";
    } else if (no == 5) {
      url = "assets/images/donggala.png";
    } else if (no == 6) {
      url = "assets/images/morowali.png";
    } else if (no == 7) {
      url = "assets/images/morut.png";
    } else if (no == 8) {
      url = "assets/images/parimo.png";
    } else if (no == 9) {
      url = "assets/images/poso.png";
    } else if (no == 10) {
      url = "assets/images/sigi.png";
    } else if (no == 11) {
      url = "assets/images/touna.png";
    } else if (no == 12) {
      url = "assets/images/tolitoli.png";
    } else if (no == 13) {
      url = "assets/images/palu.png";
    }
    return url;
  }

  dynamic buildConvertionCurrency(value) {
    return new FlutterMoneyFormatter(
        amount: value,
        settings: MoneyFormatterSettings(
          thousandSeparator: '.',
          decimalSeparator: ',',
          symbolAndNumberSeparator: ' ',
          fractionDigits: 3,
        ));
  }
}

class Sales {
  final String year;
  final int sales;
  Sales(this.year, this.sales);
}
