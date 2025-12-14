import 'package:flutter/material.dart';
import '../app_theme.dart';

class AddApartmentScreen extends StatelessWidget {
  static const String routeName = '/add';
  const AddApartmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Apartment'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'Add Apartment Screen ',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}