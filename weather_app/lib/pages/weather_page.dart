
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/service/weather_service.dart';

class WeatherPage extends StatefulWidget{
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => WeatherState();
}

class WeatherState extends State<WeatherPage>{


  final _weatherService = WeatherService('8495ebbd64085ce1548343ab7d374f9b');
  Weather? _weather;

  _fetchWeather() async{
    String cityName = await _weatherService.getCurrentCity();

    try{
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } 

    catch(e){
      print(e);
    }

  }

  String getWeatherAnimation(String? mainCondition){
    if (mainCondition == null){
      return 'assets/sunny.json';
    }

    switch(mainCondition.toLowerCase()){
      case 'clouds':
      return 'assets/windy.json';

      case 'rain':
      return 'assets/rain.json';

      case 'thunderstorm':
      return 'assets/thunderstorm.json';

      case 'clear':
      return 'assets/windy.json';

      default:
      return 'assets/windy.json';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 141, 140, 140),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weather?.cityName ?? "loading city name", 
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
        
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            Text(
              '${_weather?.temperature.round()}℃', style: TextStyle(
                color: Colors.white,
                fontSize: 29,
                fontWeight: FontWeight.bold
              ),
            ),
        
            Text(
              _weather?.mainCondition ?? "loading weather condition", style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
    );
  }
}