import 'package:flutter/material.dart';

class MealPlanPage extends StatefulWidget {
  final DateTime selectedDate;
  final DateTimeRange dateRange; // Accept the date range

  const MealPlanPage({super.key, required this.selectedDate, required this.dateRange});

  @override
  State<MealPlanPage> createState() => _MealPlanPageState();
}

class _MealPlanPageState extends State<MealPlanPage> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.selectedDate; // Initialize with the selected date
  }

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
            // Horizontal Scrollable Calendar Bar
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.dateRange.duration.inDays + 1,
                itemBuilder: (context, index) {
                  DateTime day = widget.dateRange.start.add(Duration(days: index));
                  bool isSelected = day == selectedDate;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDate = day; // Update the selected date
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          '${day.day}/${day.month}',
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Selected Date
            Text(
              'Selected Date: ${selectedDate.toLocal()}'.split(' ')[0],
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // My Meal Plan Section
            const Text(
              'My Meal Plan',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  MealPlanCard(mealType: 'Breakfast'),
                  MealPlanCard(mealType: 'Lunch'),
                  MealPlanCard(mealType: 'Dinner'),
                  MealPlanCard(mealType: 'Snack'),
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