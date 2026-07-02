import 'package:flutter/material.dart';

class HealthTipCard extends StatelessWidget {
  final String tip;

  const HealthTipCard({super.key, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.lightbulb, color: Colors.green, size: 35),
          const SizedBox(width: 15),
          Expanded(child: Text(tip, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
