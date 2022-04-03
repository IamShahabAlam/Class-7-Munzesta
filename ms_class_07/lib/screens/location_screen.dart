import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'city_screen.dart';
import 'package:intl/intl.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  String weatherIcon;
  String cityName;
  String weatherMessage;
  String weatherDescription;
  String country;


// String now = DateFormat("yyyy-MM-dd").format    

  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }
      double temp = weatherData["main"]["temp"];
        temperature = temp.toInt() ;
        print("Temperature : $temperature");

                               
        var condition = weatherData["weather"][0]["id"];
        print("City ID : $condition");


        //  longitude = weatherData["coord"]["lon"];
        // print("City Longitude : $longitude");
                                                    
        weatherDescription = weatherData["weather"][0]["description"];
        print("Weather Description : $weatherDescription");

                             
         cityName = weatherData["name"];
        print("City Name : $cityName");

        country = weatherData["sys"]["country"];
        print("Country Name : $country");
                
        
        weatherIcon = weather.getWeatherIcon(condition);
        weatherMessage = weather.getMessage(condition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('$weatherMessage'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 40.0,
                      color: Colors.black
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      FontAwesomeIcons.mapMarkedAlt,
                      size: 40.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              
                SizedBox(height: MediaQuery.of(context).size.height*0.03,),

              Center(
                child: Text(
                        weatherIcon,
                        style: kConditionTextStyle,
                      ),
              ), 


              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    
                    Text(
                      '$temperature',
                      style: kTempTextStyle,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left:15.0),
                      child: Text("°", style:TextStyle(fontSize: 80, textBaseline: TextBaseline.alphabetic),),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom:60.0 , left: 5),
                      child: Text("C", style:TextStyle(fontSize: 60, textBaseline: TextBaseline.alphabetic),),
                    ),
                    
                    
                  ],
                ),
              ),


              Row( mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                        '$cityName , ',
                        textAlign: TextAlign.right,

                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                  ),


                  Center(
                child: Text(
                    '$country',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
              ),
                ],
              ),

              
              SizedBox(height: 5,),
              
               Center(
                child: Text(
                    '$weatherDescription'.toUpperCase(),
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 25, color: Colors.white, fontFamily: "Spartan MB"),
                  ),
              ),



              Padding(
                padding: EdgeInsets.only(right: 15.0,top: 140),
                child: Center(child: 
                Text(DateFormat("dd-MM-yyyy").format(DateTime.now()),style: TextStyle(color: Colors.grey ,letterSpacing: 3,fontSize: 20),)
                ),
               
              ),

              // Text("$now"),


            ],
          ),
        ),
      ),
    );
  }
}
