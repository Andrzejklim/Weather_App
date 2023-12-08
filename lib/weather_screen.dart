import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:weather_app/additional_info_item.dart';
class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          //main card
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
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          '300.67 K',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.cloud,
                          size: 64,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Rain",
                          style: TextStyle(fontSize: 20),
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
            "Weather Forecast",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                HourlyForecastItem(time: '9:00',icon: Icons.cloud, temp: "310",),
                HourlyForecastItem(time: '12:00',icon: Icons.sunny, temp: "328",),
                HourlyForecastItem(time: '15:00',icon: Icons.sunny_snowing, temp: "228",),
                HourlyForecastItem(time: '18:00',icon: Icons.cloud, temp: "310",),
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
          const Row(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AdditionalInfoItem(icon: Icons.water_drop, desc: "humidity", value :'91'),
              AdditionalInfoItem(icon: Icons.air_sharp, desc: "Wind Speed", value : '7.5'),
              AdditionalInfoItem(icon: Icons.beach_access, desc: "Pressure", value :'100'),
            ],
          )
        ]),
      ),
    );
  }
}
