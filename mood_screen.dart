import '../services/storage_service.dart';
import 'package:flutter/material.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  final StorageService storage = StorageService();
  String selectedMood = "😊 Happy";

  final Map<String, Color> moodColors = {
    "😊 Happy": Colors.green,
    "😌 Relaxed": Colors.teal,
    "😴 Tired": Colors.deepPurple,
    "😢 Sad": Colors.blue,
    "😡 Angry": Colors.red,
    "🤩 Excited": Colors.orange,
  };

  final Map<String, String> motivation = {
    "😊 Happy":
        "Keep smiling! Your positive energy inspires everyone around you.",
    "😌 Relaxed":
        "A calm mind creates a healthy life. Keep enjoying your peaceful day.",
    "😴 Tired": "Take some rest. Your body needs recovery to stay strong.",
    "😢 Sad": "Every difficult day passes. Tomorrow brings a new beginning.",
    "😡 Angry": "Take a deep breath. Peace is more powerful than anger.",
    "🤩 Excited": "Use your excitement wisely and make today productive!",
  };

  final Map<String, String> tips = {
    "😊 Happy": "Share your happiness with someone today.",
    "😌 Relaxed": "Try 10 minutes of meditation.",
    "😴 Tired": "Drink water and get enough sleep tonight.",
    "😢 Sad": "Go for a short walk and listen to your favorite music.",
    "😡 Angry": "Take five deep breaths before reacting.",
    "🤩 Excited": "Write today's goals and achieve them one by one.",
  };

  final Map<String, int> scores = {
    "😊 Happy": 95,
    "😌 Relaxed": 90,
    "😴 Tired": 60,
    "😢 Sad": 50,
    "😡 Angry": 40,
    "🤩 Excited": 98,
  };

  @override
  @override
  void initState() {
    super.initState();
    loadMood();
  }

  Future<void> loadMood() async {
    selectedMood = await storage.readString("mood");

    if (selectedMood.isEmpty) {
      selectedMood = "😊 Happy";
    }

    setState(() {});
  }

  Widget build(BuildContext context) {
    Color currentColor = moodColors[selectedMood]!;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Mood Tracker"),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: currentColor,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [currentColor, currentColor.withOpacity(0.7)],
                ),
                borderRadius: BorderRadius.circular(25),
              ),

              child: Column(
                children: [
                  const Text(
                    "How are you feeling today?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,

                    children: moodColors.keys.map((mood) {
                      bool selected = mood == selectedMood;

                      return GestureDetector(
                        onTap: () async {
                          setState(() {
                            selectedMood = mood;
                          });

                          await storage.saveString("mood", selectedMood);
                        },

                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),

                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),

                          decoration: BoxDecoration(
                            color: selected
                                ? Colors.white
                                : Colors.white.withOpacity(0.25),

                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: Text(
                            mood,

                            style: TextStyle(
                              fontSize: 18,

                              fontWeight: FontWeight.bold,

                              color: selected ? currentColor : Colors.white,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Card(
              elevation: 5,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [
                    const Text(
                      "Today's Wellness Score",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      "${scores[selectedMood]}%",
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: currentColor,
                      ),
                    ),

                    const SizedBox(height: 15),

                    LinearProgressIndicator(
                      value: scores[selectedMood]! / 100,
                      minHeight: 12,
                      borderRadius: BorderRadius.circular(20),
                      color: currentColor,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            Card(
              elevation: 5,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [
                    const Icon(Icons.favorite, size: 55, color: Colors.pink),

                    const SizedBox(height: 15),

                    const Text(
                      "Motivation",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      motivation[selectedMood]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            Card(
              elevation: 5,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: Column(
                  children: [
                    const Icon(Icons.lightbulb, size: 50, color: Colors.amber),

                    const SizedBox(height: 15),

                    const Text(
                      "Today's Wellness Tip",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      tips[selectedMood]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: currentColor,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),

                onPressed: () {
                  setState(() {
                    selectedMood = "😊 Happy";
                  });
                },

                icon: const Icon(Icons.refresh, color: Colors.white),

                label: const Text(
                  "Reset Mood",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
