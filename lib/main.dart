import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login & Register',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<void> login() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/login/');
    var response = await http.post(url, body: {
      "username": _username.text,
      "password": _password.text,
    });

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      showDialog(context: context, builder: (_) => AlertDialog(content: Text("Login successful")));
    } else {
      showDialog(context: context, builder: (_) => AlertDialog(content: Text(data['error'] ?? 'Login failed')));
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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  Future<void> register() async {
    if (_username.text.isEmpty || _password.text.isEmpty || _confirmPassword.text.isEmpty) {
      showDialog(context: context, builder: (_) => AlertDialog(content: Text("All fields are required")));
      return;
    } else if (_password.text != _confirmPassword.text) {
      showDialog(context: context, builder: (_) => AlertDialog(content: Text("Passwords do not match")));
      return;
    }

    try {
      var url = Uri.parse('http://10.0.2.2:8000/api/register/');
      var response = await http.post(url, body: {
        "username": _username.text,
        "password": _password.text,
        "password2": _confirmPassword.text,
      });

      if (response.statusCode == 201) {
        showDialog(context: context, builder: (_) => AlertDialog(content: Text("Registration successful")));
      } else {
        var data = jsonDecode(response.body);
        showDialog(context: context, builder: (_) => AlertDialog(content: Text(data['error'] ?? 'Registration failed')));
      }
    } catch (e) {
      showDialog(context: context, builder: (_) => AlertDialog(content: Text("An error occurred: $e")));
    }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(controller: _username, decoration: const InputDecoration(labelText: 'Username')),
          TextField(controller: _password, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
          TextField(controller: _confirmPassword, obscureText: true, decoration: const InputDecoration(labelText: 'Confirm Password')),
          ElevatedButton(onPressed: register, child: const Text('Register')),
        ]),
      ),
    );
  }
}
