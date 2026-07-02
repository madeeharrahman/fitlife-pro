import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample Data
    final double steps = 80;
    final double water = 60;
    final double sleep = 90;
    final double calories = 70;

    final double overallProgress = 0.75;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Progress Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Progress Report",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 25),

            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: steps,
                      title: "Steps",
                      color: Colors.blue,
                      radius: 70,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    PieChartSectionData(
                      value: water,
                      title: "Water",
                      color: Colors.cyan,
                      radius: 70,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    PieChartSectionData(
                      value: sleep,
                      title: "Sleep",
                      color: Colors.indigo,
                      radius: 70,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    PieChartSectionData(
                      value: calories,
                      title: "Food",
                      color: Colors.orange,
                      radius: 70,
                      titleStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            Card(
              child: ListTile(
                leading: const Icon(Icons.directions_walk, color: Colors.blue),
                title: const Text("Steps"),
                trailing: Text("${steps.toInt()}%"),
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: ListTile(
                leading: const Icon(Icons.water_drop, color: Colors.cyan),
                title: const Text("Water"),
                trailing: Text("${water.toInt()}%"),
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: ListTile(
                leading: const Icon(Icons.bedtime, color: Colors.indigo),
                title: const Text("Sleep"),
                trailing: Text("${sleep.toInt()}%"),
              ),
            ),

            const SizedBox(height: 10),

            Card(
              child: ListTile(
                leading: const Icon(Icons.restaurant, color: Colors.orange),
                title: const Text("Calories"),
                trailing: Text("${calories.toInt()}%"),
              ),
            ),

            const SizedBox(height: 30),

            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Overall Progress",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: LinearProgressIndicator(
                        value: overallProgress,
                        minHeight: 12,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      "${(overallProgress * 100).toInt()}%",
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            Card(
              child: ListTile(
                leading: const Icon(Icons.calendar_month),
                title: const Text("Weekly Progress"),
                subtitle: const Text("82% completed this week"),
              ),
            ),

            const SizedBox(height: 15),

            Card(
              child: ListTile(
                leading: const Icon(Icons.flag),
                title: const Text("Today's Goal"),
                subtitle: const Text("75% completed"),
              ),
            ),

            const SizedBox(height: 25),

            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(Icons.favorite, color: Colors.red, size: 55),

                    SizedBox(height: 15),

                    Text(
                      "Keep Going!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Small progress every day leads to big achievements.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
