import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  const HourlyForecastItem({required this.time, required this.imageUrl, required this.temp,super.key});

  final String time;
  final String imageUrl;
  final String temp;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              "Time $time",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Image.network('https://openweathermap.org/img/w/$imageUrl.png', height: 35, width: 35,),

            const SizedBox(
              height: 8,
            ),
            Text(
              temp,
              style: const TextStyle(
                  fontSize: 14,
                  // fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}