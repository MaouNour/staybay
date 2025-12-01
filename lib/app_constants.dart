
import 'package:flutter/material.dart';

/// يحتوي على جميع الألوان المستخدمة في التطبيق.
class AppColors {
  // اللون الأساسي (كحلي غامق: 1, 56, 147)
  static const Color primaryBlue = Color(0xFF013893);
  // لون الخلفية
  static const Color backgroundColor = Colors.white;
  // لون حدود حقول النص (رمادي فاتح)
  static const Color outlineColor = Color(0xFFCCCCCC);
  // لون الأيقونات والنصوص الثانوية (رمادي متوسط)
  static const Color secondaryText = Color(0xFF808080);
  // لون النص الأساسي
  static const Color primaryText = Colors.black87;
  // لون الأخطاء
  static const Color errorRed = Colors.red;
}

/// يحتوي على ثوابت الأبعاد والمسافات (Padding, Radius) لضمان التناسق والاستجابة.
class AppSizes {
  // المسافات الأساسية (Padding)
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingExtraLarge = 32.0;

  // نصف القطر (Radius)
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusLarge = 12.0;

  // ارتفاع الأزرار
  static const double buttonHeight = 56.0;

  // حجم الخطوط
  static const double fontSizeTitle = 28.0;
  static const double fontSizeSubtitle = 18.0;
  static const double fontSizeLabel = 14.0;
  static const double fontSizeButton = 18.0;
}

/// يحتوي على أنماط الخطوط المستخدمة في التطبيق.
class AppStyles {
  // نمط الخط للعنوان الرئيسي
  static const TextStyle titleStyle = TextStyle(
    fontSize: AppSizes.fontSizeTitle,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryText,
  );

  // نمط الخط لتسميات الحقول
  static const TextStyle labelStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: AppSizes.fontSizeLabel,
    color: AppColors.primaryText,
  );

  // نمط الخط لزر التسجيل
  static const TextStyle buttonTextStyle = TextStyle(
    color: Colors.white,
    fontSize: AppSizes.fontSizeButton,
    fontWeight: FontWeight.bold,
  );
}

/// يحتوي على ثوابت الـRoutes.
class AppRoutes {
  static const String welcome = '/';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String success = '/success';
  // تم تغيير الاسم هنا ليصبح مطابقًا لـ homePage
  static const String homePage = '/homePage'; 
}

/// مسار وهمي للصورة داخل assets (استبدله بالمسار الفعلي لشعارك)
class AppAssets {
  static const String logoPath = 'assets/images/app_logo.png'; 
}
