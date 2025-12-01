
import 'package:flutter/material.dart';
import 'app_constants.dart';

/// يوفر AppTheme إعدادات الثيم (Light/Dark) .
class AppTheme {
  /// ثيم الإضاءة (Light Theme) للتطبيق.
  static ThemeData get lightTheme {
    return ThemeData(
      // اللون الأساسي المستخدم في التطبيق.
      primaryColor: AppColors.primaryBlue,
      // خلفية التطبيق الافتراضية.
      scaffoldBackgroundColor: AppColors.backgroundColor,
      // مخطط الألوان العام.
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryBlue,
        secondary: AppColors.primaryBlue,
        error: AppColors.errorRed,
        surface: AppColors.backgroundColor,
      ),
      // إعدادات شريط التطبيق (AppBar).
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundColor,
        iconTheme: IconThemeData(color: AppColors.primaryText),
        elevation: 0,
        centerTitle: true,
      ),
      // إعدادات حقول إدخال النص.
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppSizes.paddingMedium,
          horizontal: AppSizes.paddingLarge,
        ),
        // الأنماط الافتراضية لجميع الحدود
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
          borderSide: const BorderSide(color: AppColors.outlineColor, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
          borderSide: const BorderSide(color: AppColors.outlineColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
          borderSide: const BorderSide(color: AppColors.primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
          borderSide: const BorderSide(color: AppColors.errorRed, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
          borderSide: const BorderSide(color: AppColors.errorRed, width: 2.0),
        ),
        labelStyle: AppStyles.labelStyle.copyWith(
          color: AppColors.secondaryText,
          fontWeight: FontWeight.normal,
        ),
        hintStyle: AppStyles.labelStyle.copyWith(
          color: AppColors.secondaryText,
        ),
      ),
      // إعدادات الأزرار المرتفعة.
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, AppSizes.buttonHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
          ),
          textStyle: AppStyles.buttonTextStyle,
          elevation: 5, // إضافة ظل خفيف للأزرار كما في صورة Sign Up
        ),
      ),
      // استخدام Material 3.
      useMaterial3: true,
    );
  }
}
