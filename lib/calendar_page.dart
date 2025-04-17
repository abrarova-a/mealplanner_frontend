import 'package:flutter/material.dart';
import 'profile_page.dart'; // Import the ProfilePage
import 'meal_plan_page.dart'; // Import the MealPlanPage

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Planner'),
        leading: IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            // Navigate to the Profile Page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfilePage()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          // Calendar Widget
          Expanded(
            child: CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              onDateChanged: (date) {
                setState(() {
                  _selectedDate = date;
                });
              },
            ),
          ),
          // Button to navigate to the Meal Plan Page
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_selectedDate != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MealPlanPage(selectedDate: _selectedDate!),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a date')),
                  );
                }
              },
              child: const Text('Plan Your Meal'),
            ),
          ),
        ],
      ),
    );
  }
}