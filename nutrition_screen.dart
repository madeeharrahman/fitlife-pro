import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => NutritionScreenState();
}

class NutritionScreenState extends State<NutritionScreen> {
  final StorageService storage = StorageService();

  final breakfastController = TextEditingController();
  final lunchController = TextEditingController();
  final dinnerController = TextEditingController();
  final snacksController = TextEditingController();

  int totalCalories = 0;

  String advice = "";

  Color adviceColor = Colors.green;

  final int goal = 2000;

  @override
  void initState() {
    super.initState();
    loadNutrition();
  }

  Future<void> loadNutrition() async {
    breakfastController.text = (await storage.readInt("breakfast")).toString();

    lunchController.text = (await storage.readInt("lunch")).toString();

    dinnerController.text = (await storage.readInt("dinner")).toString();

    snacksController.text = (await storage.readInt("snacks")).toString();
  }

  Future<void> calculateCalories() async {
    await storage.saveInt(
      "breakfast",
      int.tryParse(breakfastController.text) ?? 0,
    );

    await storage.saveInt("lunch", int.tryParse(lunchController.text) ?? 0);

    await storage.saveInt("dinner", int.tryParse(dinnerController.text) ?? 0);

    await storage.saveInt("snacks", int.tryParse(snacksController.text) ?? 0);

    int breakfast = int.tryParse(breakfastController.text) ?? 0;
    int lunch = int.tryParse(lunchController.text) ?? 0;
    int dinner = int.tryParse(dinnerController.text) ?? 0;
    int snacks = int.tryParse(snacksController.text) ?? 0;

    totalCalories = breakfast + lunch + dinner + snacks;

    if (totalCalories < 1200) {
      advice = "⚠️ You need more healthy food today.";
      adviceColor = Colors.orange;
    } else if (totalCalories <= 2000) {
      advice = "✅ Excellent! Your calorie intake is balanced.";
      adviceColor = Colors.green;
    } else {
      advice = "🍔 You exceeded your calorie goal today.";
      adviceColor = Colors.red;
    }

    setState(() {});
  }

  void resetData() {
    breakfastController.clear();
    lunchController.clear();
    dinnerController.clear();
    snacksController.clear();

    totalCalories = 0;
    advice = "";
    adviceColor = Colors.green;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text("Nutrition Tracker"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 20),

            const Icon(Icons.restaurant, size: 120, color: Colors.green),

            const SizedBox(height: 20),

            const Text(
              "Track Today's Calories",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 25),
            TextField(
              controller: breakfastController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Breakfast Calories",
                prefixIcon: const Icon(Icons.free_breakfast),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: lunchController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Lunch Calories",
                prefixIcon: const Icon(Icons.lunch_dining),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: dinnerController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Dinner Calories",
                prefixIcon: const Icon(Icons.dinner_dining),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: snacksController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Snacks Calories",
                prefixIcon: const Icon(Icons.cookie),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: calculateCalories,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Calculate Calories",
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

            if (totalCalories > 0) ...[
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
                        "Today's Calories",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        "$totalCalories kcal",
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: adviceColor,
                        ),
                      ),

                      const SizedBox(height: 20),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          value: (totalCalories / goal).clamp(0.0, 1.0),
                          minHeight: 15,
                          backgroundColor: Colors.grey.shade300,
                          color: adviceColor,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        "${((totalCalories / goal).clamp(0.0, 1.0) * 100).toInt()}% of Daily Goal",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Icon(Icons.flag, color: Colors.blue, size: 60),

                      const SizedBox(height: 15),

                      const Text(
                        "Daily Goal",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "$goal kcal",
                        style: const TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(Icons.lightbulb, color: adviceColor, size: 55),

                      const SizedBox(height: 15),

                      const Text(
                        "Nutrition Advice",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Text(
                        advice,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: adviceColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    breakfastController.dispose();
    lunchController.dispose();
    dinnerController.dispose();
    snacksController.dispose();
    super.dispose();
  }
}
