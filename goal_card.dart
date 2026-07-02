import 'package:flutter/material.dart';

class GoalCard extends StatelessWidget {
  final int currentSteps;
  final int goalSteps;

  const GoalCard({
    super.key,
    required this.currentSteps,
    required this.goalSteps,
  });

  @override
  Widget build(BuildContext context) {
    double progress = currentSteps / goalSteps;

    if (progress > 1) {
      progress = 1;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 90,
                height: 90,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 8,
                  color: Colors.green,
                  backgroundColor: Colors.grey.shade300,
                ),
              ),

              Text(
                "${(progress * 100).toInt()}%",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(width: 20),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Daily Goal",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                Text(
                  "$currentSteps / $goalSteps Steps",
                  style: const TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 10),

                Text(
                  "${goalSteps - currentSteps} Steps Remaining",
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
