import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/modals/weather.dart';
import 'package:flutter_weather_app/modals/net_images.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_weather_app/screens/search_result_screen.dart';

class searchWeather extends StatefulWidget {
  const searchWeather({Key? key}) : super(key: key);

  @override
  _searchWeatherState createState() => _searchWeatherState();
}

class _searchWeatherState extends State<searchWeather> {

  ///creating an images object in order to access the properties and method from the Images class in net_image.dart
  Images images = new Images();

  ///creating a weather_details object in order to access the properties and method from the Weather class in weather.dart
  Weather weather_details = Weather();

  ///search and find weather details by city
  Future<void> getweather(String city) async{

    ///assigning the api key generated via openweathermap.org to a const variable 'apiKey'
    const apiKey = '3c54ab9d26042e0eb89ccfed5f34cb23';

    ///creates a new Uri object by parsing a URI string to 'url' variable
    var url = Uri.parse("http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric");

    ///fetches data from the weather api via web
    http.Response  response =  await http.get(url);
    ///returns the json object
    var result =  jsonDecode(response.body);

    ///printing api response details
    if (kDebugMode) {
       print('Searched Weather Details:' + response.body);
      //print('Navigated to Search Screen');
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

    ///returning searched result api values when navigating to the search_result_screen.dart screen via MaterialPageRoute
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return  searchResult(
        temp: weather_details.temp,
        currently: weather_details.currently,
        description: weather_details.description,
        feels_like: weather_details.feels_like,
        humidity: weather_details.humidity,
        icon: weather_details.icon,
        name: weather_details.name,
        speed: weather_details.speed,
      );
    }));
  }

  ///controller for TextField - search
  TextEditingController nameController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF030615),
      body:SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  ///TextField & selection buttons
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: we * 0.8,
                      height:he * 0.055,
                      margin: const EdgeInsets.only(left: 20,top: 30),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white10,
                      ),
                      child:  TextField(
                        controller: nameController,
                        onSubmitted: (value){
                          getweather(nameController.text);
                        },
                        decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          border:InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                          hintStyle: TextStyle(
                            color:  Colors.white,
                          ),
                        ),
                        style:  const TextStyle(color: Colors.white,fontWeight:FontWeight.bold),),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: const Icon(Icons.clear_outlined,color: Colors.red,)
                        ))
                  ],
                ),
                SizedBox(
                  height: he * 0.03,
                ),
                ///   << popular cities >>  ///
                Row(
                  // row cities //
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        getweather("Colombo");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: we * 0.2,
                        height: he * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white12
                        ),

                        child: const Text("Colombo",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    SizedBox(
                      width: we * 0.03,
                    ),
                    GestureDetector(
                      onTap: (){
                        getweather("Shanghai");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: we * 0.2,
                        height: he * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white12
                        ),

                        child: const Text("Shanghai",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    SizedBox(
                      width: we * 0.03,
                    ),
                    GestureDetector(
                      onTap: (){
                        getweather("Melbourne");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: we * 0.25,
                        height: he * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white12
                        ),
                        child: const Text("Melbourne",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: he * 0.03,
                ),
                ///2 row cities
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        getweather("Delhi");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: we * 0.25,
                        height: he * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white12
                        ),
                        child: const Text("Delhi",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    SizedBox(
                      width: we * 0.03,
                    ),
                    GestureDetector(
                      onTap: (){
                        getweather("Jakarta");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: we * 0.2,
                        height: he * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white12
                        ),

                        child: const Text("Jakarta",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    SizedBox(
                      width: we * 0.03,
                    ),
                  ],
                ),
                SizedBox(
                  height: he * 0.03,
                ),
                ///3 rows cities
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        getweather("Tokyo");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: we * 0.25,
                        height: he * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white12
                        ),
                        child: const Text("Tokyo",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    SizedBox(
                      width: we * 0.03,
                    ),
                    GestureDetector(
                      onTap: (){
                        getweather("Paris");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: we * 0.2,
                        height: he * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white12
                        ),
                        child: const Text("Paris",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    SizedBox(
                      width: we * 0.03,
                    ),
                    GestureDetector(
                      onTap: (){
                        getweather("New York");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: we * 0.2,
                        height: he * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white12
                        ),
                        child: const Text("New York",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ],
                ),
              ],),
          ),),
      ),
    );
  }
 }





