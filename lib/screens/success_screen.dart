
import 'package:flutter/material.dart';
import '../app_constants.dart';
import '../widgets/custom_primary_button.dart';

/// شاشة النجاح التي تظهر بعد تسجيل الدخول أو التسجيل.
class SuccessScreen extends StatelessWidget {
  /// يحدد ما إذا كان النجاح لتسجيل الدخول أو التسجيل لضبط النص.
  final bool isLoginSuccess; 

  const SuccessScreen({super.key, this.isLoginSuccess = true});

  @override
  Widget build(BuildContext context) {
    // استخدام MediaQuery لضمان الاستجابة
    final screenHeight = MediaQuery.of(context).size.height;

    // تحديد الرسائل بناءً على نوع العملية
    final String title = isLoginSuccess 
        ? 'Thank you, login succeeded!' 
        : 'Thank you, registration succeeded!';
    final String buttonText = 'Go to Home Page';
    // النص الثانوي يتغير حسب نوع العملية
    final String secondaryText = isLoginSuccess 
        ? 'You have successfully logged into your account.'
        : 'Your account has been created successfully.';

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.paddingLarge),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                
              CircleAvatar(
                radius: screenHeight * 0.1,
                backgroundColor: AppColors.primaryBlue.withOpacity(0.1),
                child: Icon(
                  Icons.check,
                  size: screenHeight * 0.08,
                  color: AppColors.primaryBlue,
                ),
              ),

              SizedBox(height: screenHeight * 0.05),

              // رسالة النجاح الرئيسية
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppStyles.titleStyle.copyWith(
                  fontSize: AppSizes.fontSizeSubtitle * 1.2,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: AppSizes.paddingSmall),
              // رسالة النجاح الثانوية
              Text(
                secondaryText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: AppSizes.fontSizeLabel,
                  color: AppColors.secondaryText,
                ),
              ),

              SizedBox(height: screenHeight * 0.08),
              
              // زر الانتقال إلى الرئيسية (Home)
              CustomPrimaryButton(
                text: buttonText,
                onPressed: () {
                  // استخدام pushReplacement للانتقال إلى HomePage
                  Navigator.of(context).pushReplacementNamed(AppRoutes.homePage);
                },
              ),
              
              SizedBox(height: screenHeight * 0.03),

              // شروط الخدمة والخصوصية
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.paddingMedium),
                child: Text(
                  'By continuing, you agree to our Terms of Service and Privacy Policy',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: AppSizes.fontSizeLabel * 0.9,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}