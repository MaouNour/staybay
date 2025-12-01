
import 'package:flutter/material.dart';
import '../app_constants.dart';
import '../widgets/custom_primary_button.dart';   

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  // منطق الانتقال إلى شاشة الدخول
  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.login);
  }

  // منطق الانتقال إلى شاشة التسجيل
  void _navigateToSignUp(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.signUp);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // القسم العلوي يشغل 59% من الشاشة لضمان أن يكون المنحنى مرئياً بشكل جيد
    final topSectionHeight = screenHeight * 0.59; 

    return Scaffold(
      // استخدام لون الخلفية من الثوابت
      backgroundColor: AppColors.backgroundColor, 
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. القسم العلوي (الخلفية الزرقاء مع المنحنى)
            SizedBox(
              height: topSectionHeight,
              width: double.infinity,
              child: ClipPath(
                clipper: WelcomeClipper(),
                child: Container(
                  color: AppColors.primaryBlue, // استخدام لون الثوابت
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // أيقونة المنزل
                        const Icon(
                          Icons.home_work,
                          size: 100,
                          color: Colors.white,
                        ),
                        const SizedBox(height: AppSizes.paddingSmall),
                        // عنوانstay bay  
                        const Text(
                          'STAY BAY',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2.0,
                          ),
                        ),
                        // العنوان الثانوي
                        Text(
                          'Dream House',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: AppSizes.fontSizeSubtitle,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        // مسافة إضافية لتجنب تداخل النصوص مع المنحنى
                        SizedBox(height: screenHeight * 0.05),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            // 2. القسم السفلي (النصوص والأزرار)
            Padding(
              // استخدام الهوامش من الثوابت
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingLarge), 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'WELCOME',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w900,
                      color: AppColors.primaryText, // استخدام لون النص الأساسي
                    ),
                  ),
                  const SizedBox(height: AppSizes.paddingSmall),
                  
                  // النصوص الوصفية
const Text(
                    'Find your next space, Feel at home',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppSizes.fontSizeLabel,
                      color: AppColors.secondaryText, // استخدام لون النص الثانوي
                      ),
                  ),
                  const SizedBox(height: AppSizes.paddingSmall / 2),
                  const Text(
                    'Where comfort meets convenience',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppSizes.fontSizeLabel,
                      color: AppColors.secondaryText,
                    ),
                  ),
                  const SizedBox(height: AppSizes.paddingExtraLarge),
                  
                  // زر تسجيل الدخول (Login Button)  
                  CustomPrimaryButton(
                    text: 'Login',
                    onPressed: () => _navigateToLogin(context),
                  ),

                  const SizedBox(height: AppSizes.paddingMedium),
                  
                  // زر تسجيل حساب جديد (Sign Up Button)
                  SizedBox(
                    width: double.infinity,
                    height: AppSizes.buttonHeight,
                    child: OutlinedButton(
                      onPressed: () => _navigateToSignUp(context),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.backgroundColor,
                        // استخدام لون الحدود من الثوابت لضمان التناسق
                        side: const BorderSide(color: AppColors.outlineColor, width: 1.5), 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge * 2), // 24.0
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: AppColors.primaryText, // استخدام لون النص الأساسي
                          fontSize: AppSizes.fontSizeButton,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // مسافة في الأسفل لتحسين الهوامش
                  const SizedBox(height: AppSizes.paddingExtraLarge),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

                  // 📐 كلاس المنحنى (CustomClipper)
class WelcomeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    
    path.lineTo(0, 0); 
    path.lineTo(0, size.height * 0.82); 

    var controlPoint = Offset(size.width / 2, size.height * 0.99); 
    var endPoint = Offset(size.width, size.height * 0.82);

    path.quadraticBezierTo(
      controlPoint.dx, 
      controlPoint.dy, 
      endPoint.dx, 
      endPoint.dy,
    );
    
    path.lineTo(size.width, 0);
    path.close();
    
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
