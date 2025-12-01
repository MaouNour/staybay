
import 'package:flutter/material.dart';
import '../app_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page', style: TextStyle(color: AppColors.primaryText)),
        backgroundColor: AppColors.backgroundColor,
        automaticallyImplyLeading: false, // لا نريد زر العودة للصفحة السابقة
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 80,
              color: AppColors.primaryBlue,
            ),
            const SizedBox(height: AppSizes.paddingMedium),
            Text(
              'Welcome to the Home Page!',
              style: AppStyles.titleStyle.copyWith(color: AppColors.primaryBlue),
            ),
            const SizedBox(height: AppSizes.paddingMedium),
            Text(
              'You successfully navigated through the flow.',
              style: TextStyle(color: AppColors.secondaryText),
            ),
          ],
        ),
      ),
    );
  }
}