import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:weather_app/additional_info_item.dart';
// import 'package:weather/weather.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';
import 'package:weather_app/unix_time_converter.dart';

// WeatherFactory wf = new WeatherFactory(openWeatherAPIKey, language: Language.DANISH);
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  double temp = 0;
  String cityName = "Manchester";
  late Future<Map<String,dynamic>> weather;

  Future<Map<String, dynamic>> getCurrentWeather() async {
    
    try {
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$openWeatherAPIKey'),
      );

      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw data['message'];
      }

      return data;
      // temp =  data['list'][0]['main']['temp'];
    } catch (e) {
      throw e.toString();
    }
  }

   @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  weather = getCurrentWeather();
                });
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return (const Center(child: CircularProgressIndicator.adaptive()));
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final data = snapshot.data!;
          final currentWeatherData = data['list'][0];
          final currentTemp = currentWeatherData['main']['temp'];
          final currentSky = currentWeatherData['weather'][0]['main'];
          final currentImageCode = currentWeatherData['weather'][0]['icon'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];
          final currentHumidity = currentWeatherData['main']['humidity'];
          final currentPressure = currentWeatherData['main']['pressure'];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                cityName,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              '$currentTemp K',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // Icon(
                            //   currentSky == 'Clouds' || currentSky == "Rain" ? Icons.cloud : Icons.sunny,
                            //   size: 64,
                            // ),
                            Image.network(
                              'https://openweathermap.org/img/w/$currentImageCode.png',
                              height: 64,
                              width: 64,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              '$currentSky',
                              style: const TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Hourly Forecast",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // for (int i = 1; i < 8; i++)
                    //   HourlyForecastItem(
                    //     time: unixToTime(data['list'][i - 1]['dt']),
                    //     imageUrl:
                    //         (data['list'][i]['weather'][0]['icon']).toString(),
                    //     temp: (data['list'][i]['main']['temp']).toString(),
                    //   ),
                    SizedBox(
                      height: 120,
                      width: 400,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return HourlyForecastItem(
                            time: unixToTime(data['list'][index]['dt']),
                            imageUrl: (data['list'][index]['weather'][0]
                                    ['icon'])
                                .toString(),
                            temp: (data['list'][index]['main']['temp'])
                                .toString(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Additional Information",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                // mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AdditionalInfoItem(
                      icon: Icons.water_drop,
                      desc: "humidity",
                      value: '$currentHumidity'),
                  AdditionalInfoItem(
                      icon: Icons.air_sharp,
                      desc: "Wind Speed",
                      value: '$currentWindSpeed'),
                  AdditionalInfoItem(
                      icon: Icons.beach_access,
                      desc: "Pressure",
                      value: '$currentPressure'),
                ],
              )
            ]),
          );
        },
      ),
    );
  }
}
