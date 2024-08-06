// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'weather_tile.dart';

class MainWidget extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final location;
  final temp;
  final tempMin;
  final tempMax;
  final weather;
  final humidity;
  final windSpeed;

  MainWidget({
    required this.location,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.weather,
    required this.humidity,
    required this.windSpeed,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            color: Color(0xfff1f1f1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${location.toString()}',
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    '${temp.toInt()}°C',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 40.0,
                      color: Colors.purple,
                    ),
                  ),
                ),
                Text(
                  'High of ${tempMax.toString()}°C of${tempMin.toString()}°C',
                  //         'High of ${tempMax.toInt().toString()}°C of${tempMin.toInt().toString()}°C',
                  style: TextStyle(
                    color: Color(0xff9e9e9e),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(12),
            child: ListView(children: [
              WeatherTile(
                icon: Icons.thermostat_outlined,
                title: 'Temperature',
                subtitle: '${temp.toString()}°C',
              ),
              WeatherTile(
                icon: Icons.filter_drama_outlined,
                title: 'Weather',
                subtitle: '${weather.toString()}',
              ),
              WeatherTile(
                icon: Icons.wb_sunny,
                title: 'Humidity',
                subtitle: '${humidity.toString()}%',
              ),
              WeatherTile(
                icon: Icons.waves_outlined,
                title: 'Wind Speed',
                subtitle: '${windSpeed.toString()} MPH',
              ),
            ]),
          ))
        ],
      ),
    );
  }
}
