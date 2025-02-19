import 'package:flutter/material.dart';
import 'package:graphical_model_interface/pages/home.dart';
import 'package:graphical_model_interface/theme.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16),
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Login', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Col.blue),
                  elevation: WidgetStateProperty.all<double>(1),
                ),
                child: const Text(
                  'Login',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
