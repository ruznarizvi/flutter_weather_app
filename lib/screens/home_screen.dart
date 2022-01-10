import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/screens/weather_forecast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_weather_app/screens/search_screen.dart';
import 'package:flutter_weather_app/modals/weather.dart';
import 'package:flutter_weather_app/utils/date_time.dart';
import 'package:flutter_weather_app/modals/net_images.dart';
import 'package:location/location.dart';
import 'package:flutter_weather_app/widgets/loading.dart';


///the _weather enum defines the possible navigation route which is chosen to be displayed
enum _weather{
  weather,
  search,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ///creating an images object in order to access the properties and method from the Images class in net_image.dart
  Images images = Images();

  ///creating a weather_details object in order to access the properties and method from the Weather class in weather.dart
  Weather weather_details = Weather();

  ///assigning colors
  Color deactivecolor = Colors.white24;
  Color active = Colors.white;
  _weather ? selected;

///get weather based on current location
  Future<void> getWeatherLocation() async{
    //creating a location object
    Location location = Location();
    ///getting current location and assigning it to currentLocation variable
    var currentLocation = await location.getLocation();

    ///getting longitude and latitudes based on current location
    var lon = currentLocation.longitude;
    var lat = currentLocation.latitude;

    ///assigning the api key generated via openweathermap.org to a const variable 'apiKey'
    const apiKey = '3c54ab9d26042e0eb89ccfed5f34cb23';

    ///creates a new Uri object by parsing a URI string to 'url' variable
    var url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric");


    ///fetches data from the weather api via web
    http.Response response =  await http.get(url);
    ///returns the json object
    var result =  jsonDecode(response.body);

    ///printing api response details
    if (kDebugMode) {
      // print('Current Weather Details:' + response.body);
      print('Navigated to Home Screen');
    }

    setState(() {
      ///assigning openweathermap api values
      weather_details.temp = result['main']['temp'];
      weather_details.description = result["weather"][0]['description'];
      weather_details.currently = result["weather"][0]['main'];
      weather_details.feels_like = result["main"]['feels_like'];
      weather_details.humidity = result["main"]['humidity'];
      weather_details.speed = result["wind"]['speed'];
      weather_details.name = result["name"];

      ///weather images displayed based on weather condition
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
      else if (weather_details.currently.toString() == "Fog"){
        weather_details.icon = images.Fog;
      }
    });
  }

  ///called exactly once for each State object the it creates
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
        ///if weather.details.humidity is not null, the following widgets are displayed
        child:weather_details.humidity != null  ? Container(
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
                              height: he * 0.06,
                            ),
                            const FittedBox(
                              child: Icon(
                                  Icons.location_on_rounded,
                                  size: 40,
                                  color: Colors.amber
                              ),
                            ),
                            SizedBox(
                              height: he * 0.01,
                            ),
                            const Text('current location',style: TextStyle(color: Colors.white60,
                                fontSize: 20.0),),
                            SizedBox(
                              height: he * 0.03,
                            ),
                            ///current date is displayed
                            Text(formattedDate.toString(),style: const TextStyle(color: Colors.white70,fontWeight: FontWeight.bold,
                                fontSize: 20.0),),
                            SizedBox(
                              height: he * 0.02,
                            ),
                            ///name of the city based on the current weather location is displayed
                            Text(weather_details.name.toString(),style:GoogleFonts.alata(
                              fontSize: 30.0,
                              color: Colors.white,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            )),
                            SizedBox(
                              height: he * 0.02,
                            ),
                            ///weather condition image is displayed
                            Expanded(child: CachedNetworkImage(imageUrl: weather_details.icon.toString())),
                            SizedBox(
                              height: he * 0.01,
                            ),
                            ///current weather condition is displayed (ex: Clouds, Rain, Mist etc..)
                            Text(weather_details.currently.toString(),style: const TextStyle(color: Colors.white,
                                fontWeight: FontWeight.bold,fontSize: 20.0),),
                            SizedBox(
                              height: he * 0.01,
                            ),
                            ///current temperature is displayed in degrees celsius (ex: 26°C)
                            Text(weather_details.temp.toString()+"°C",style: GoogleFonts.asap(
                              color: Colors.white70,
                              fontSize: 68.0,
                              fontWeight: FontWeight.bold,
                            )),
                            SizedBox(
                              height: he * 0.03,
                            ),
                            ///box of additional weather information
                            Container(
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
                                  /// >>>  Wind Speed >> //
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
                                  /// >>>  Humidity >> //
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
                                  /// >>>  Feels-like >> //
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
          ///else, the loading widget is displayed
        ):const Loading(),
      ),

    ///if weather.details.humidity is not null, the following widgets are displayed
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>weatherForecast(city: weather_details.name.toString(),)));
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
                    selected = _weather.search;
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return const searchWeather();
                    }));
                  });
                },
                child:  Icon(Icons.search_outlined,color: selected == _weather.search ? active : deactivecolor,size: 38.0,)),
          ],),
        ///else, the loading widget is displayed
      ): const Loading(),
    );}
 }