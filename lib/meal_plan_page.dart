import 'package:flutter/material.dart';

class MealPlanPage extends StatelessWidget {
  final DateTime selectedDate;

  const MealPlanPage({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Plan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selected Date: ${selectedDate.toLocal()}'.split(' ')[0],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'My Meal Plan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  MealPlanCard(mealType: 'Breakfast'),
                  MealPlanCard(mealType: 'Lunch'),
                  MealPlanCard(mealType: 'Dinner'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MealPlanCard extends StatelessWidget {
  final String mealType;

  const MealPlanCard({super.key, required this.mealType});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: const Icon(Icons.add, color: Colors.green),
        title: Text('Add $mealType'),
        onTap: () {
          // Add functionality to add meals
        },
      ),
    );
  }
}