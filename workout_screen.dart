import 'package:flutter/material.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final TextEditingController workoutController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  int calories = 0;

  String workout = "";

  void calculateWorkout() {
    if (workoutController.text.isEmpty || durationController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields.")));

      return;
    }

    workout = workoutController.text;

    int minutes = int.parse(durationController.text);

    calories = minutes * 8;

    setState(() {});
  }

  void resetWorkout() {
    workoutController.clear();

    durationController.clear();

    calories = 0;

    workout = "";

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workout Tracker"),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 20),

            const Icon(Icons.fitness_center, size: 120, color: Colors.red),

            const SizedBox(height: 20),

            TextField(
              controller: workoutController,

              decoration: InputDecoration(
                labelText: "Workout Name",

                prefixIcon: const Icon(Icons.sports_gymnastics),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: durationController,

              keyboardType: TextInputType.number,

              decoration: InputDecoration(
                labelText: "Duration (Minutes)",

                prefixIcon: const Icon(Icons.timer),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: calculateWorkout,

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,

                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),

                child: const Text(
                  "Calculate",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,

              child: OutlinedButton(
                onPressed: resetWorkout,

                child: const Text("Reset"),
              ),
            ),

            const SizedBox(height: 30),

            if (calories > 0)
              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.red.shade50,

                  borderRadius: BorderRadius.circular(20),

                  border: Border.all(color: Colors.red),
                ),

                child: Column(
                  children: [
                    Text(
                      workout,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      "$calories Calories Burned",
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "${durationController.text} Minutes Completed",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
