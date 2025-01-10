import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('This is the Home Screen'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // context.pushNamed(Routes.loginScreen);
        },
        child: const Icon(Icons.login),
      ),
    );
  }
}
