import 'package:flutter/material.dart';
import '../services/storage_service.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final StorageService storage = StorageService();

  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  double bmi = 0;
  String category = "";
  Color resultColor = Colors.blue;

  @override
  void initState() {
    super.initState();
    loadBMI();
  }

  Future<void> loadBMI() async {
    heightController.text = (await storage.readDouble("height")).toString();

    weightController.text = (await storage.readDouble("weight")).toString();
  }

  Future<void> calculateBMI() async {
    if (heightController.text.isEmpty || weightController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter height and weight.")),
      );
      return;
    }

    double height = double.parse(heightController.text);
    double weight = double.parse(weightController.text);

    await storage.saveDouble("height", height);
    await storage.saveDouble("weight", weight);

    double heightMeter = height / 100;

    bmi = weight / (heightMeter * heightMeter);

    if (bmi < 18.5) {
      category = "Underweight";
      resultColor = Colors.orange;
    } else if (bmi < 25) {
      category = "Normal Weight";
      resultColor = Colors.green;
    } else if (bmi < 30) {
      category = "Overweight";
      resultColor = Colors.deepOrange;
    } else {
      category = "Obese";
      resultColor = Colors.red;
    }

    setState(() {});
  }

  void resetData() {
    heightController.clear();
    weightController.clear();

    bmi = 0;
    category = "";

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Icon(
              Icons.monitor_weight,
              size: 100,
              color: Colors.deepPurple,
            ),

            const SizedBox(height: 20),

            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Height (cm)",
                prefixIcon: const Icon(Icons.height),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Weight (kg)",
                prefixIcon: const Icon(Icons.fitness_center),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: calculateBMI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Calculate BMI",
                  style: TextStyle(fontSize: 18, color: Colors.white),
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

            if (bmi != 0)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: resultColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: resultColor),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Your BMI",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Text(
                      bmi.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: resultColor,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      category,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: resultColor,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      bmi < 18.5
                          ? "You are underweight. Try eating a balanced diet."
                          : bmi < 25
                          ? "Great! Your BMI is in the healthy range."
                          : bmi < 30
                          ? "You are overweight. Regular exercise can help."
                          : "Your BMI is high. Consider consulting a healthcare professional.",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }
}
