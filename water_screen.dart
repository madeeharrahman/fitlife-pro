import '../services/storage_service.dart';
import 'package:flutter/material.dart';

class WaterScreen extends StatefulWidget {
  const WaterScreen({super.key});

  @override
  State<WaterScreen> createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  final StorageService storage = StorageService();
  int water = 5;
  final int goal = 8;

  void increaseWater() async {
    if (water < goal) {
      setState(() {
        water++;
      });

      await storage.saveInt("water", water);
    }
  }

  void decreaseWater() async {
    if (water > 0) {
      setState(() {
        water--;
      });

      await storage.saveInt("water", water);
    }
  }

  @override
  @override
  void initState() {
    super.initState();
    loadWater();
  }

  Future<void> loadWater() async {
    water = await storage.readInt("water");

    if (water == 0) {
      water = 5;
    }

    setState(() {});
  }

  Widget build(BuildContext context) {
    double progress = water / goal;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Water Tracker"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 20),

            const Icon(Icons.water_drop, size: 120, color: Colors.blue),

            const SizedBox(height: 20),

            const Text(
              "Today's Water Goal",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              "$water / $goal Glasses",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              "Remaining: ${goal - water} Glasses",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 20),

            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 15,
                backgroundColor: Colors.grey.shade300,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 15),

            Text(
              "${(progress * 100).toInt()}% Completed",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                FloatingActionButton(
                  heroTag: "minus",
                  backgroundColor: Colors.red,
                  onPressed: decreaseWater,
                  child: const Icon(Icons.remove),
                ),

                FloatingActionButton(
                  heroTag: "plus",
                  backgroundColor: Colors.green,
                  onPressed: increaseWater,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 40),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: water == goal
                    ? Colors.green.shade100
                    : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                water == goal
                    ? "🎉 Congratulations!\n\nYou reached today's water goal!"
                    : "💧 Stay hydrated! Drinking enough water helps improve your energy, focus, and overall health.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
