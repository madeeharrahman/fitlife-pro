import 'progress_screen.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../widgets/dashboard_card.dart';
import '../widgets/quick_action_button.dart';
import '../widgets/streak_card.dart';

import 'bmi_screen.dart';
import 'mood_screen.dart';
import 'nutrition_screen.dart';
import 'profile_screen.dart';
import 'sleep_screen.dart';
import 'water_screen.dart';
import 'workout_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int steps = 6250;
  int calories = 450;
  int water = 5;
  double sleep = 7.5;

  int streak = 12;

  String mood = "😊 Happy";

  double progress = 0.72;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.backgroundTop, AppColors.backgroundBottom],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getGreeting(),
                  style: const TextStyle(color: Colors.white70, fontSize: 18),
                ),

                const SizedBox(height: 5),

                const Text(
                  "Madeeha Rahman",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  getDate(),
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),

                const SizedBox(height: 25),

                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Today's Progress",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 12,
                          backgroundColor: Colors.black12,
                          color: Colors.green,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        "${(progress * 100).toInt()}% Completed",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                StreakCard(streak: streak),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: DashboardCard(
                        title: "Steps",
                        value: "$steps",
                        icon: Icons.directions_walk,
                        color: Colors.blue,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: DashboardCard(
                        title: "Calories",
                        value: "$calories",
                        icon: Icons.local_fire_department,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                Row(
                  children: [
                    Expanded(
                      child: DashboardCard(
                        title: "Water",
                        value: "$water Glasses",
                        icon: Icons.water_drop,
                        color: Colors.cyan,
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: DashboardCard(
                        title: "Sleep",
                        value: "$sleep hrs",
                        icon: Icons.bedtime,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.favorite, color: Colors.pink, size: 40),

                      const SizedBox(width: 15),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Today's Mood",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(mood, style: const TextStyle(fontSize: 22)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  "Quick Actions",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: [
                    QuickActionButton(
                      icon: Icons.fitness_center,
                      title: "Workout",
                      color: Colors.red,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const WorkoutScreen(),
                          ),
                        );
                      },
                    ),

                    QuickActionButton(
                      icon: Icons.water_drop,
                      title: "Water",
                      color: Colors.blue,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const WaterScreen(),
                          ),
                        );
                      },
                    ),

                    QuickActionButton(
                      icon: Icons.monitor_weight,
                      title: "BMI",
                      color: Colors.green,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const BmiScreen()),
                        );
                      },
                    ),

                    QuickActionButton(
                      icon: Icons.bedtime,
                      title: "Sleep",
                      color: Colors.indigo,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SleepScreen(),
                          ),
                        );
                      },
                    ),

                    QuickActionButton(
                      icon: Icons.restaurant,
                      title: "Nutrition",
                      color: Colors.green,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NutritionScreen(),
                          ),
                        );
                      },
                    ),

                    QuickActionButton(
                      icon: Icons.mood,
                      title: "Mood",
                      color: Colors.orange,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const MoodScreen()),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,

        onDestinationSelected: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProgressScreen()),
            );
          }

          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }
        },

        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),

          NavigationDestination(icon: Icon(Icons.bar_chart), label: "Progress"),

          NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  //--------------------------------
  // Greeting Function
  //--------------------------------
  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning ☀️";
    } else if (hour < 17) {
      return "Good Afternoon 🌤️";
    } else {
      return "Good Evening 🌙";
    }
  }

  //--------------------------------
  // Current Date Function
  //--------------------------------
  String getDate() {
    final now = DateTime.now();

    const months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];

    return "${months[now.month - 1]} ${now.day}, ${now.year}";
  }
}
