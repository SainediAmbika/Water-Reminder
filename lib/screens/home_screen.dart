import 'package:flutter/material.dart';
import 'package:water_reminder/screens/notification_service.dart';

final List<int> waterOptions = [100, 200, 300, 500];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int goal = 2000; // daily goal in ml
  int intake = 0; // water consumed

  @override
  Widget build(BuildContext context) {
    double progress = intake / goal;
    if (progress > 1) progress = 1; // Cap progress at 100%

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            "Water Reminder",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circular Progress with % and intake/goal
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 12,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.blue,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${(progress * 100).toStringAsFixed(0)}%",

                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "$intake / $goal ml",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Quick add water options
            Wrap(
              spacing: 10,
              children: waterOptions.map((amount) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(90, 60),
                    shape: CircleBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 3),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      intake += amount;
                      if (intake > goal)
                        intake = goal; // Prevent exceeding goal
                    });
                  },
                  child: Text("$amount ml"),
                );
              }).toList(),
            ),

            const SizedBox(height: 100),
            SizedBox(height: 80, width: 300, child: NotificationService()),
          ],
        ),
      ),
    );
  }
}
