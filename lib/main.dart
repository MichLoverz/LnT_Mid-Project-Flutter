import 'package:flutter/material.dart';
import 'models/step_entry.dart';
import 'models/water_entry.dart';
import 'screens/home_screen.dart';
import 'screens/steps_tracker_screen.dart';
import 'screens/water_intake_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // Shared data lists
  final List<StepEntry> _stepEntries = [];
  final List<WaterEntry> _waterEntries = [];

  @override
  Widget build(BuildContext context) {
    // Rebuild screens on every build so HomeScreen reflects latest data
    final screens = [
      HomeScreen(
        stepEntries: _stepEntries,
        waterEntries: _waterEntries,
      ),
      StepsTrackerScreen(stepEntries: _stepEntries),
      WaterIntakeScreen(waterEntries: _waterEntries),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.blue.shade700,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_walk),
            label: 'Steps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop),
            label: 'Water',
          ),
        ],
      ),
    );
  }
}
