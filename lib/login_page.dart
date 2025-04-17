import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import for JSON decoding
import 'calendar_page.dart'; // Import CalendarPage for navigation
import 'register_page.dart'; // Import RegisterPage for navigation

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<void> login() async {
    if (_username.text.isEmpty || _password.text.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(content: Text("All fields are required")),
      );
      return;
    }

    try {
      var url = Uri.parse('http://10.0.2.2:8000/api/login/');
      var response = await http.post(url, body: {
        "username": _username.text,
        "password": _password.text,
      });

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const CalendarPage()),
        );
      } else {
        var data = jsonDecode(response.body);
        showDialog(
          context: context,
          builder: (_) => AlertDialog(content: Text(data['error'] ?? 'Login failed')),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(content: Text("An error occurred: $e")),
      );
    }
  }

  void goToRegister() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(controller: _username, decoration: const InputDecoration(labelText: 'Username')),
          TextField(controller: _password, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
          ElevatedButton(onPressed: login, child: const Text('Login')),
          TextButton(onPressed: goToRegister, child: const Text("Don't have an account? Register")),
        ]),
      ),
    );
  }
}