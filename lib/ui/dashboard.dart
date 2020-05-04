import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meva_covid_19/ui/animation/fade_animation.dart';
import 'package:meva_covid_19/ui/detail_regency.dart';
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}



class _DashboardState extends State<Dashboard> {
  final String url_regency = "https://banuacoders.com/api/pico/kabupaten";
    final String url_covid_world = "https://coronavirus-19-api.herokuapp.com/all";
  final String url_covid_indonesia =
      "https://coronavirus-19-api.herokuapp.com/countries/indonesia";
  final String url_covid_sulteng =
      "https://banuacoders.com/api/pico/provinsi/72";
      static dynamic data_covid_world;
  static dynamic data_covid_indonesia;
  static dynamic data_covid_sulteng;
  List data_regency;

  Future<String> getDataAllCovidWorld() async {
    var res = await http.get(Uri.encodeFull(url_covid_world),
        headers: {'accept': 'application/json'});
    setState(() {
      var content = json.decode(res.body);
      data_covid_world = content;
      print(data_covid_world);
    });
    return 'success!';
  }

  Future<String> getDataCovidIndonesia() async {
    var res = await http.get(Uri.encodeFull(url_covid_indonesia),
        headers: {'accept': 'application/json'});
    setState(() {
      var content = json.decode(res.body);
      data_covid_indonesia = content;
      print(data_covid_indonesia);
    });
    return 'success!';
  }

  Future<String> getDataCovidSulteng() async {
    var res = await http.get(Uri.encodeFull(url_covid_sulteng),
        headers: {'accept': 'application/json'});
    setState(() {
      var content = json.decode(res.body);
      data_covid_sulteng = content["data"];
      print(data_covid_sulteng);
    });
    return 'success!';
  }




  Future<String> getDataRegency() async {
    var res = await http
        .get(Uri.encodeFull(url_regency), headers: {'accept': 'application/json'});

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
    this.getDataAllCovidWorld();
    this.getDataCovidIndonesia();
    this.getDataCovidSulteng();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff0f4c81),
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          data_regency == null ? new Center(
            child: new Column(
              children: <Widget>[
                new SizedBox(height: 100,),
                new CircularProgressIndicator(),
                new Text("Menunggu Data", style: new TextStyle(color: Colors.white,),),
              ],
            )
          ) : new FadeAnimation(0.3, Container(
            margin: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(data_regency[10]["kabupaten"], style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),),
                    Container(
                      child: Row(
                        children: <Widget>[
                          new GestureDetector(onTap: (){
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context){
                                  return DetailRegency(no: data_regency[10]["no"], data: data_regency[10], data_covid_indonesia: data_covid_indonesia, data_covid_sulteng: data_covid_sulteng, data_covid_world: data_covid_world,);
                                }
                              ),);
                          }, child: new Icon(Icons.open_in_new, color: Colors.white,)),
                          SizedBox(width : 10,),
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: Image.asset("assets/images/touna.png", fit: BoxFit.contain,),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),

                Text("Sulawesi Tengah", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.blue[100]),),

                SizedBox(height : 24,),

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
                              borderRadius: BorderRadius.all(Radius.circular(18))
                            ),
                            child: Center(child: Text(data_regency[10]["ODP"].toString(), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.yellow),)),
                            padding: EdgeInsets.all(12),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text("ODP", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.yellow),),
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
                                borderRadius: BorderRadius.all(Radius.circular(18))
                            ),
                            child: Center(child: Text(data_regency[10]["PDP"].toString(), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.amber),)),
                            padding: EdgeInsets.all(12),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text("PDP", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.amber),),
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
                                borderRadius: BorderRadius.all(Radius.circular(18))
                            ),
                            child: Center(child: Text(data_regency[10]["positif"].toString(), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.orange),)),
                            padding: EdgeInsets.all(12),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text("Positif", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.orange),),
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
                                borderRadius: BorderRadius.all(Radius.circular(18))
                            ),
                            child: Center(child: Text(data_regency[10]["meninggal"].toString(), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.red),)),
                            padding: EdgeInsets.all(12),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text("Meninggal", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.red),),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height : 24,),
                Text("Pembaharuan Data Per Tanggal : ${DateTime.parse(data_regency[10]["updated_at"]).toString().split(".").first}", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Colors.lightGreen[100]),),
              ],
            ),
          ),),


          //draggable sheet
          DraggableScrollableSheet(
            builder: (context, scrollController){
              return Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(243, 245, 248, 1),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 24,),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Kabupaten", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24, color: Colors.black),),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 32),
                      ),
                      SizedBox(height: 24,),
                      
                      data_regency == null ? new Center(
                              child: new Column(
                                children: <Widget>[
                                  new CircularProgressIndicator(),
                                  new Text("Menunggu Data"),
                                ],
                              ),
                            ) : ListView.builder(
                        itemBuilder: (context, index){
                          return new GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context){
                                  return DetailRegency(no: data_regency[index]["no"], data: data_regency[index], data_covid_indonesia: data_covid_indonesia, data_covid_sulteng: data_covid_sulteng, data_covid_world: data_covid_world,);
                                }
                              ),);
                            },
                                                      child: new FadeAnimation(0.9, Container(
                              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[100],
                                        borderRadius: BorderRadius.all(Radius.circular(18))
                                    ),
                                    child: new Container(
                                      width: 40,
                                      height: 40,
                                      decoration: new BoxDecoration(
                                        image: new DecorationImage(
                                          image: AssetImage(getImageRegencyByNo(data_regency[index]["no"])),
                                          fit: BoxFit.contain,
                                        )
                                      )
                                    ),
                                    padding: EdgeInsets.all(12),
                                  ),

                                  SizedBox(width: 16,),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(data_regency[index]["kabupaten"], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey[900]),),
                                        Text(DateTime.parse(data_regency[index]["updated_at"]).toString().split(".").first, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      new Row(
                                        children: <Widget>[
                                          new  Icon(Icons.radio_button_checked, size: 10,color: Colors.yellow,),
                                          Text(data_regency[index]["ODP"].toString(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.yellow),),
                                        ],
                                      ),
                                      new Row(
                                        children: <Widget>[
                                          new  Icon(Icons.radio_button_checked, size: 10,color: Colors.amber,),
                                          Text(data_regency[index]["PDP"].toString(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.amber),),
                                        ],
                                      ),
                                      new Row(
                                        children: <Widget>[
                                          new  Icon(Icons.radio_button_checked, size: 10,color: Colors.orange,),
                                          Text(data_regency[index]["positif"].toString(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.orange),),
                                        ],
                                      ),
                                      new Row(
                                        children: <Widget>[
                                          new  Icon(Icons.radio_button_checked, size: 10,color: Colors.red,),
                                          Text(data_regency[index]["meninggal"].toString(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.red),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),),
                          );
                        },
                        shrinkWrap: true,
                        itemCount: data_regency.length,
                        padding: EdgeInsets.all(0),
                        controller: ScrollController(keepScrollOffset: false),
                      ),
                    ],
                  ),
                  controller: scrollController,
                ),
              );
            },
            initialChildSize: 0.6,
            minChildSize: 0.6,
            maxChildSize: 1,
          )
        ],
      ),
    );
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
}
