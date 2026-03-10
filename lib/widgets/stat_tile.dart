import 'package:flutter/material.dart';

class StatTile extends StatelessWidget {

  final String name;
  final int value;
  final String rank;

  const StatTile({
    super.key,
    required this.name,
    required this.value,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [

        Text(
          "$name:",
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 18,
          ),
        ),

        const SizedBox(width: 6),

        Text(
          value.toString(),
          style: const TextStyle(
            color: Color(0xFFFF3B3B),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          "($rank)",
          style: const TextStyle(
            color: Color(0xFF8C6A3E),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}