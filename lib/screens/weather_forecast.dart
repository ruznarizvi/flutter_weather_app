import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class weatherForecast extends StatefulWidget {
  String city = "";
  weatherForecast({required this.city});
  @override
  _weatherForecastState createState() => _weatherForecastState();
}

class _weatherForecastState extends State<weatherForecast> {

  var weatherDate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text('5 day forecast - ${widget.city}',
          style: const TextStyle(color:Colors.white),
        ),
        centerTitle: true,

      ),

      ///checking if weather date is empty
      body: (weatherDate==null?
          ///if empty, app displays loading screen
      const Center(child: CircularProgressIndicator(),):
          ///display items in list format
      ListView.builder(itemCount: (weatherDate==null?0:weatherDate['list'].length),
          itemBuilder: (context,index){
            return Card(
              color: Colors.black45,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        ///display weather condition image
                        CircleAvatar(
                          //images/
                          backgroundImage: AssetImage(
                            "assets/images/${weatherDate['list'][index]['weather'][0]['main'].toString().toLowerCase()}.PNG",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ///display weather date
                              Text(DateFormat('E-dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(weatherDate['list'][index]['dt']*1000000)),
                                style: const TextStyle(color:Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
                              ),
                              ///display weather time and weather type
                              Text("${DateFormat('HH:mm').format(DateTime.fromMicrosecondsSinceEpoch(weatherDate['list'][index]['dt']*1000000))} "
                                  " | ${weatherDate['list'][index]['weather'][0]['main'].toString().toLowerCase()}",
                                style: const TextStyle(color:Colors.amber, fontSize: 18,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ///display weather temperature in degree celsius
                    Text("${(weatherDate['list'][index]['main']['temp']-272.15).round()} °C",
                      style: const TextStyle(color:Colors.lightGreen, fontSize: 22,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          })
      ),


    );
  }

  ///fetching data from openweathermap API
  Future<void> getData(String city) async {

    ///assigning the api key generated via openweathermap.org to a const variable 'apiKey'
    const apiKey = '3c54ab9d26042e0eb89ccfed5f34cb23';

    ///creates a new Uri object by parsing a URI string to 'url' variable
    var url = Uri.parse("http://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey");

    ///fetches data from the weather api via web
    http.Response response =  await http.get(url);

    http.get(url).then((onResp) {
   //print(onResp.body);
      setState(() {
        this.weatherDate=json.decode(response.body);

      });
    //print(weatherDate);
    }).catchError((onError){
    });
  }
}