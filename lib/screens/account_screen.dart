import 'package:flutter/material.dart';
import '../app_theme.dart';

class AccountScreen extends StatelessWidget {
  static const String routeName = '/account';
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'Account Screen ',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}