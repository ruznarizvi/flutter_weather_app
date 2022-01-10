import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);
  @override
  _LoadingState createState() => _LoadingState();
}
class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    var he = MediaQuery.of(context).size.height;
    return  SafeArea(
      child: Center(
        /// loading screen...
        child: Column(
          children: <Widget>[
            Expanded(child: CachedNetworkImage(imageUrl: "https://i.pinimg.com/originals/77/0b/80/770b805d5c99c7931366c2e84e88f251.png")),
            SizedBox(
              height: he * 0.085,
            ),
            Container(
              width: 50.0,
              height: 50.0,
              margin: const EdgeInsets.only(bottom: 150.0),
              child: const LoadingIndicator(
                  indicatorType: Indicator.ballRotateChase, /// The loading type of the widget
                  colors:  [Colors.blue],
                  strokeWidth: 2, /// The stroke of the line, only applicable to widget which contains line
                  backgroundColor: Color(0xFF030615), /// Background color of the widget
                  pathBackgroundColor: Colors.black
              ),),
          ],),
      ),);}
}

