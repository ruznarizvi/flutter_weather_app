import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_weather_app/screens/search_screen.dart';
import 'package:flutter_weather_app/modals/weather.dart';
import 'package:flutter_weather_app/utils/date_time.dart';
import 'package:flutter_weather_app/modals/net_images.dart';
import 'package:location/location.dart';
import 'package:flutter_weather_app/widgets/loading.dart';




enum _weather{
  weather,
  add,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  // image //
  Images images = Images();
  // image //

  // data //
  Weather weather_details = Weather();
  // data //


  //  colors //
  Color deactivecolor = Colors.white24;
  Color active = Colors.white;
  _weather ? selected;


  Future<void> getWeatherLocation() async{
    // location //
    Location location = Location();
    var currentLocation = await location.getLocation();

    var lon = currentLocation.longitude;
    var lat = currentLocation.latitude;
    // location //

    const apiKey = '3c54ab9d26042e0eb89ccfed5f34cb23';
    // weather //
    var url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric");


    http.Response response =  await http.get(url);
    var result =  jsonDecode(response.body);


    setState(() {
      weather_details.temp = result['main']['temp'];
      weather_details.description = result["weather"][0]['description'];
      weather_details.currently = result["weather"][0]['main'];
      weather_details.feels_like = result["main"]['feels_like'];
      weather_details.humidity = result["main"]['humidity'];
      weather_details.speed = result["wind"]['speed'];
      weather_details.name = result["name"];

      //weather images displayed based on weather condition
      if(weather_details.currently.toString() == "Clouds"){
        weather_details.icon = images.Clouds;
      }
      else if (weather_details.currently.toString() == "Clear"){
        weather_details.icon = images.Clear;
      }
      else if (weather_details.currently.toString() == "Mist"){
        weather_details.icon = images.Mist;
      }
      else if (weather_details.currently.toString() == "Haze"){
        weather_details.icon = images.Mist;
      }
      else if (weather_details.currently.toString() == "Snow"){
        weather_details.icon = images.Snow;
      }
      else if (weather_details.currently.toString() == "Rain"){
        weather_details.icon = images.Raining;
      }
      else if (weather_details.currently.toString() == "Thunderstorm"){
        weather_details.icon = images.Thunderstorm;
      }
    });
  }


  // get weather and location//
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherLocation();
  }


  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF030615),
      body: SafeArea(
        child:weather_details.humidity != null  ? Expanded(
          child: SizedBox(
              width: we,
              height: he,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        alignment: Alignment.topCenter,
                        width: we * 0.97,
                        height: he * 0.88,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF3996AD),Color(0xFF1D3990)],
                              begin: FractionalOffset(0.0,0.0),
                              end: FractionalOffset(0.0, 1.6),
                            )
                        ),
                        child:Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            SizedBox(
                              height: he * 0.07,
                            ),
                            Text(formattedDate.toString(),style: const TextStyle(color: Colors.white60,fontWeight: FontWeight.bold,fontSize: 20.0),),
                            SizedBox(
                              height: he * 0.02,
                            ),
                            Text(weather_details.name.toString(),style:GoogleFonts.alata(
                              fontSize: 30.0,
                              color: Colors.white,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            )),
                            SizedBox(
                              height: he * 0.02,
                            ),

                            Expanded(child: CachedNetworkImage(imageUrl: weather_details.icon.toString())),
                            SizedBox(
                              height: he * 0.025,
                            ),
                            Text(weather_details.currently.toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),),
                            SizedBox(
                              height: he * 0.02,
                            ),
                            Text(weather_details.temp.toString()+"°",style: GoogleFonts.asap( // 31°
                              color: Colors.white70,
                              fontSize: 70.0,
                              fontWeight: FontWeight.bold,
                            )),


                            SizedBox(
                              height: he * 0.03,
                            ),


                            Container(
                              // box of information //
                              width: we * 0.85,
                              height:he * 0.19,
                              margin: const EdgeInsets.only(bottom: 50.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: const Color(0xFF4677AD),
                              ),
                              child: Row(

                                children: <Widget>[
                                  SizedBox(
                                    width: we * 0.08,
                                  ),

                                  // >>>  Wind >> //
                                  Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: he * 0.01,
                                      ),
                                      Text("Wind",style: GoogleFonts.alata(
                                          color: Colors.white70,
                                          fontSize: 18.0
                                      )),
                                      CachedNetworkImage(imageUrl: "https://img.icons8.com/fluency/2x/wind.png",width: we * 0.1,height: he * 0.1,),
                                      Text(weather_details.speed.toString()+"mph",style: GoogleFonts.alata(
                                          color: Colors.white,
                                          fontSize: 16.0
                                      )),

                                    ],
                                  ),

                                  SizedBox(
                                    width: we * 0.09,
                                  ),

                                  // >>>  Humidity >> //
                                  Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: he * 0.01,
                                      ),
                                      Text("Humidity",style: GoogleFonts.alata(
                                          color: Colors.white70,
                                          fontSize: 18.0
                                      )),
                                      SizedBox(
                                        height: he * 0.001,
                                      ),
                                      CachedNetworkImage(imageUrl:"https://img.icons8.com/fluency/2x/wet.png",width: we * 0.12,height: he * 0.1),

                                      Text(weather_details.humidity.toString() + "%",style: GoogleFonts.alata(
                                          color: Colors.white,
                                          fontSize: 16.0
                                      )),
                                    ],
                                  ),

                                  SizedBox(
                                    width: we * 0.075,
                                  ),


                                  // >>>  Feeling >> //
                                  Column(

                                    children: <Widget>[
                                      SizedBox(
                                        height: he * 0.01,
                                      ),
                                      Text("Feeling",style: GoogleFonts.alata(
                                          color: Colors.white70,
                                          fontSize: 18.0
                                      )),
                                      SizedBox(
                                        height: he * 0.001,
                                      ),
                                      CachedNetworkImage(imageUrl:"https://img.icons8.com/color/2x/temperature.png",width: we * 0.1,height: he * 0.1),
                                      Text(weather_details.feels_like.toString()+"°C",style: GoogleFonts.alata(
                                          color: Colors.white,
                                          fontSize: 16.0
                                      )),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                    ),
                  ),
                ],
              )
          ),
        ):const Loading(),
      ),


      bottomNavigationBar: weather_details.humidity != null ? SizedBox(
        width: we * 0.08,
        height: he * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
            GestureDetector(
                onTap: (){
                  setState(() {
                    selected = _weather.weather;
                  });
                },
                child: Icon(Icons.filter_drama_outlined,color:selected == _weather.weather ? active : deactivecolor,size: 38.0,)
            ),
            SizedBox(
              width: we * 0.08,
            ),
            GestureDetector(
                onTap: (){
                  setState(() {
                    selected = _weather.add;
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return const searchWeather();
                    }));
                  });
                },
                child:  Icon(Icons.search_outlined,color: selected == _weather.add ? active : deactivecolor,size: 38.0,)
            ),

          ],
        ),
      ): const Loading(),
    );
  }
}