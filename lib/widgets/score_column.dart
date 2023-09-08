import 'package:flutter/material.dart';

class ScoreColumn extends StatelessWidget {
  final String name;
  final String points;
  const ScoreColumn({super.key, required this.name, required this.points});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          points,
          style: const TextStyle(fontSize: 25),
        )
      ],
    );
  }
}
