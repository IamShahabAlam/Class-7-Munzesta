import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/earth.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              
              
              SizedBox(height: 20,),

              Container(
                padding: EdgeInsets.all(30.0),
                child: TextField(
                  style: TextStyle(
                    color: Colors.cyan,
                  ),
                  decoration: kTextFieldInputDecoration,
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, cityName);
                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),


              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row( mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.angleLeft,
                        size: 30.0,color: Colors.grey[700],
                      ),

                      Text("Back" , style: TextStyle(
                        fontSize: 25,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
