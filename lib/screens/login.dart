import 'package:flutter/material.dart';
import 'package:xoundbucket/screens/songList.dart';
import 'package:xoundbucket/screens/profile.dart';
import 'package:xoundbucket/utils/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void printvalues() {
    final emailText = _emailController.text;
    final passwordText = _passwordController.text;
    print("Email string: $emailText");
    print("password string: $passwordText");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement login logic
                  printvalues();
                  Map<String, String> user = {
                    'email': _emailController.text,
                    'password': _passwordController.text,
                  };
                  addUser(user);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (ctx) => Profile()));
                  print('Login clicked');
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
