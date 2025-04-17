import 'package:flutter/material.dart';
import 'calendar_page.dart'; // Import CalendarPage
import 'login_page.dart'; // Import LoginPage

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> isLoggedIn() async {
    // Replace this with actual logic to check if the user is logged in
    return false; // Assume the user is not logged in for now
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (snapshot.hasData && snapshot.data == true) {
          return const MaterialApp(
            title: 'Meal Planner',
            home: CalendarPage(), // Show CalendarPage if logged in
          );
        } else {
          return const MaterialApp(
            title: 'Meal Planner',
            home: LoginPage(), // Show LoginPage if not logged in
          );
        }
      },
    );
  }
}