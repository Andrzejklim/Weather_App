import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  const AdditionalInfoItem({super.key, required this.icon, required this.desc, required this.value});

  final IconData icon;
  final String desc;
  final String value;



  @override
  Widget build(BuildContext context) {
    return Card(
                elevation: 0,
                child: Container(
                  // width: 105,
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Column(
                    children: [
                      Icon(icon, 
                      size: 35,),
                      const SizedBox(
                        height: 8
                      ),
                      Text(desc),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        value,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              );
  }
}