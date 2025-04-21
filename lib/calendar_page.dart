import 'package:flutter/material.dart';
import 'meal_plan_page.dart';
import 'profile_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTimeRange? _selectedDateRange; // To store the selected date range
  DateTime _focusedDate = DateTime.now(); // The currently focused date in the calendar
  DateTime? _startDate; // Start date of the range
  DateTime? _endDate; // End date of the range

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Planner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navigate to the Profile Page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Calendar Widget
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7, // 7 days in a week
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: DateTime.daysPerWeek * 6, // Approximate number of days to display
                itemBuilder: (context, index) {
                  DateTime day = _focusedDate.add(Duration(days: index - _focusedDate.weekday + 1));
                  bool isSelected = (_startDate != null && _endDate != null) &&
                      (day.isAfter(_startDate!) || day.isAtSameMomentAs(_startDate!)) &&
                      (day.isBefore(_endDate!) || day.isAtSameMomentAs(_endDate!));

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_startDate == null || (_startDate != null && _endDate != null)) {
                          // Set the start date
                          _startDate = day;
                          _endDate = null;
                        } else if (_startDate != null && _endDate == null) {
                          // Set the end date
                          if (day.isAfter(_startDate!)) {
                            _endDate = day;
                          } else {
                            // If the selected day is before the start date, reset
                            _startDate = day;
                          }
                        }
                        // Update the selected date range
                        if (_startDate != null && _endDate != null) {
                          _selectedDateRange = DateTimeRange(start: _startDate!, end: _endDate!);
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          '${day.day}',
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
          ),
          // Display the selected date range
          if (_selectedDateRange != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Selected Range: ${_selectedDateRange!.start.toLocal()} - ${_selectedDateRange!.end.toLocal()}'.split(' ')[0],
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          // Plan My Meals Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _selectedDateRange != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MealPlanPage(
                            selectedDate: _selectedDateRange!.start,
                            dateRange: _selectedDateRange!,
                          ),
                        ),
                      );
                    }
                  : null, // Disable the button if no date range is selected
              child: const Text('Plan My Meals'),
            ),
          ),
        ],
      ),
    );
  }
}