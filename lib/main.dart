// ignore_for_file: prefer_typing_uninitialized_variables, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'widegets/main_widget.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'WEATHER APPLICATION',
    home: MyApp(),
  ));
}

Future<WeatherInfo> fetchWeather() async {
  const zipCode = '600011';
  //const apiKey = '98893099a9816d8553bc86f247140280';
  const apiKey = '279fa465e26790fe73d90f4568704ba0';
  const requestUri =
      'https://api.openweathermap.org/data/2.5/weather?zip=$zipCode,in&units=metric&appid=$apiKey';
  final response = await http.get(Uri.parse(requestUri));

  if (response.statusCode == 200) {
    return WeatherInfo.fromJSON(jsonDecode(response.body));
    // return WeatherInfo.fromJSON(jsonDecode(SourceBuffer.abortEvent as String));
  } else {
    throw Exception('error loading requested URL info');
  }
}

class WeatherInfo {
  final location;
  final temp;
  final tempMin;
  final tempMax;
  final weather;
  final humidity;
  final windSpeed;

  WeatherInfo({
    required this.location,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.weather,
    required this.humidity,
    required this.windSpeed,
  });

  factory WeatherInfo.fromJSON(Map<String, dynamic> json) {
    return WeatherInfo(
        location: json['name'],
        temp: json['main']['temp'],
        tempMin: json['main']['tempmin'],
        tempMax: json['main']['tempMax'],
        weather: json['weather'][0]['description'],
        humidity: json['main']['humidity'],
        windSpeed: json['wind']['Speed']);
  }
}

class MyApp extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<WeatherInfo> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<WeatherInfo>(
          future: futureWeather,
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return MainWidget(
                location: snapShot.data?.location,
                temp: snapShot.data?.temp,
                tempMin: snapShot.data?.tempMin,
                tempMax: snapShot.data?.tempMax,
                weather: snapShot.data?.weather,
                humidity: snapShot.data?.humidity,
                windSpeed: snapShot.data?.windSpeed,
              );
            } else if (snapShot.hasError) {
              return Center(
                child: Text("${snapShot.error}"),
              );
            }
            return Container();
          }),
    );
  }
}
