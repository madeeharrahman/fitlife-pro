import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen> {
  final StorageService storage = StorageService();

  final TextEditingController sleepController = TextEditingController();

  double quality = 3;

  int sleepScore = 0;

  String status = "";

  String advice = "";

  Color statusColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    loadSleep();
  }

  Future<void> loadSleep() async {
    double hours = await storage.readDouble("sleepHours");
    double savedQuality = await storage.readDouble("sleepQuality");

    if (hours != 0) {
      sleepController.text = hours.toString();
    }

    if (savedQuality != 0) {
      quality = savedQuality;
    }

    setState(() {});
  }

  Future<void> calculateSleep() async {
    if (sleepController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter sleep hours")));
      return;
    }

    double hours = double.parse(sleepController.text);

    await storage.saveDouble("sleepHours", hours);
    await storage.saveDouble("sleepQuality", quality);

    if (hours >= 8) {
      sleepScore = 100;
      status = "Excellent Sleep 😍";
      advice = "Great job! Keep maintaining your healthy sleep routine.";
      statusColor = Colors.green;
    } else if (hours >= 7) {
      sleepScore = 85;
      status = "Good Sleep 😊";
      advice = "Very good! Try sleeping 30 minutes earlier.";
      statusColor = Colors.lightGreen;
    } else if (hours >= 6) {
      sleepScore = 70;
      status = "Average Sleep 😐";
      advice = "Your body needs a little more rest.";
      statusColor = Colors.orange;
    } else {
      sleepScore = 45;
      status = "Poor Sleep 😴";
      advice = "Try sleeping at least 7–8 hours every night.";
      statusColor = Colors.red;
    }

    sleepScore += (quality * 2).toInt();

    if (sleepScore > 100) {
      sleepScore = 100;
    }

    setState(() {});
  }

  void resetData() {
    sleepController.clear();

    quality = 3;

    sleepScore = 0;

    status = "";

    advice = "";

    statusColor = Colors.blue;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Sleep Tracker"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 20),

            const Icon(Icons.bedtime, color: Colors.indigo, size: 120),

            const SizedBox(height: 20),

            const Text(
              "How many hours did you sleep?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: sleepController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),

              decoration: InputDecoration(
                hintText: "Example: 7.5",
                prefixIcon: const Icon(Icons.access_time),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Text(
              "Sleep Quality : ${quality.toInt()} ⭐",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            Slider(
              value: quality,
              min: 1,
              max: 5,
              divisions: 4,
              activeColor: Colors.indigo,
              label: quality.toInt().toString(),
              onChanged: (value) {
                setState(() {
                  quality = value;
                });
              },
            ),

            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: calculateSleep,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Calculate Sleep",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: resetData,
                child: const Text("Reset"),
              ),
            ),

            const SizedBox(height: 30),

            if (sleepScore > 0) ...[
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        "Sleep Score",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        "$sleepScore%",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),

                      const SizedBox(height: 20),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          value: sleepScore / 100,
                          minHeight: 15,
                          backgroundColor: Colors.grey.shade300,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(
                        Icons.nightlight_round,
                        color: statusColor,
                        size: 60,
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        "Sleep Status",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        status,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.lightbulb,
                        color: Colors.amber,
                        size: 55,
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        "Sleep Advice",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        advice,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    sleepController.dispose();
    super.dispose();
  }
}
