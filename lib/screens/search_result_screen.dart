import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/screens/home_screen.dart';
import 'package:flutter_weather_app/screens/search_screen.dart';
import 'package:flutter_weather_app/screens/weather_forecast.dart';
import 'package:flutter_weather_app/widgets/loading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_weather_app/utils/date_time.dart';

///the _weather enum defines the possible navigation route which is chosen to be displayed
enum _weather{
  weather,
  search,
  home,
}
class searchResult extends StatefulWidget {
  searchResult({required this.temp,required this.humidity,required this.description,required this.currently,required this.name,
    required this.icon, required this.feels_like,required this.speed});
  var temp;
  var description;
  var speed;
  var currently;
  var humidity;
  var feels_like;
  var name;
  var icon;

  @override
  State<StatefulWidget> createState() {
    return _searchResultState(currently: currently,description: description,feels_like: feels_like,icon: icon,humidity: humidity,
          name: name,speed: speed,temp: temp);
  }
}

class _searchResultState extends State<searchResult> {
  _searchResultState({required this.temp,required this.humidity,required this.description,required this.currently,required this.name,
    required this.icon,required this.feels_like,required this.speed});
  var temp;
  var description;
  var speed;
  var currently;
  var humidity;
  var feels_like;
  var name;
  var icon;

  ///assigning colors
  Color deactivecolor = Colors.white24;
  Color active = Colors.white;
  _weather ? selected;

  @override
  ///displaying searched result values
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: const Color(0xFF030615),
        body:SafeArea(
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
                            ///current date is displayed
                            Text(formattedDate.toString(),style: const TextStyle(color: Colors.white60,fontWeight: FontWeight.bold,fontSize: 20.0),),
                            SizedBox(
                              height: he * 0.02,
                            ),
                            Text(name.toString(),style:GoogleFonts.alata(
                              fontSize: 30.0,
                              color: Colors.white,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            )),
                            SizedBox(
                              height: he * 0.02,
                            ),
                            Expanded(child: CachedNetworkImage(imageUrl:  icon.toString())),
                            SizedBox(
                              height: he * 0.025,
                            ),
                            Text(currently.toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),),
                            SizedBox(
                              height: he * 0.02,
                            ),
                            Text(temp.toString()+"°",style: GoogleFonts.asap( // 31°
                              color: Colors.white60,
                              fontSize: 70.0,
                              fontWeight: FontWeight.bold,
                            )),
                            SizedBox(
                              height: he * 0.03,
                            ),
                            /// box of information
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
                                  /// >>>  Wind Speed >> ///
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
                                      Text(speed.toString()+"mph",style: GoogleFonts.alata(
                                          color: Colors.white,
                                          fontSize: 16.0
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    width: we * 0.09,
                                  ),
                                  /// >>>  Humidity >> ///
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
                                      Text(humidity.toString() + "%",style: GoogleFonts.alata(
                                          color: Colors.white,
                                          fontSize: 16.0
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    width: we * 0.075,
                                  ),
                                  /// >>>  Feels-like >> ///
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
                                      Text(feels_like.toString()+"°C",style: GoogleFonts.alata(
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
                ],)
          ),
        ),
      ///if weather.details.humidity is not null, the following widgets are displayed
      bottomNavigationBar: humidity != null ? SizedBox(
        width: we * 0.08,
        height: he * 0.08,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  <Widget>[
            GestureDetector(
                onTap: (){
                  setState(() {
                    selected = _weather.weather;
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>weatherForecast(city: name.toString(),)));
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
            SizedBox(
              width: we * 0.08,
            ),
            GestureDetector(
                onTap: (){
                  setState(() {
                    selected = _weather.home;
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return const HomeScreen();
                    }));
                  });
                },
                child:  Icon(Icons.home_rounded,color: selected == _weather.home ? active : deactivecolor,size: 38.0,)),
          ],
        ),
        ///else, the loading widget is displayed
      ): const Loading(),
    );
  }
 }


