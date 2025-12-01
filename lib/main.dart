// import 'package:sta';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staybay/app_constants.dart';
import 'package:staybay/app_theme.dart';
import 'package:staybay/cubits/locale/locale_state.dart';
import 'package:staybay/cubits/locale/locale_cubit.dart';
import 'package:staybay/cubits/theme/theme_cubit.dart';
import 'package:staybay/cubits/theme/theme_state.dart';
import 'package:staybay/screens/home_page_screen.dart';
import 'package:staybay/screens/login_screen.dart';
import 'package:staybay/screens/sign_up_screen.dart';
import 'package:staybay/screens/success_screen.dart';
import 'package:staybay/screens/welcome_screen.dart';
// import 'package:staybay/test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themestate) {
          return BlocBuilder<LocaleCubit, LocaleState>(
            builder: (context, loctalestate) {
              return MaterialApp(
                builder: (context, child) {
                  return Directionality(
                    textDirection: loctalestate.textDirection,
                    child: child!,
                  );
                },
                theme: AppTheme.lightTheme,
                
                darkTheme: ThemeData(
                  brightness: Brightness.dark,
                  primaryColor: Colors.red,
                  primaryColorDark: Colors.deepPurple,
                  primaryColorLight: Colors.redAccent,
                ),
                themeMode: themestate is DarkModeState
                    ? ThemeMode.dark
                    : ThemeMode.light,
                // home: Test(),
                      // تعريف نظام Routes للتنقل السلس
      initialRoute: AppRoutes.welcome,
      routes: {
        // الشاشة الافتتاحية
        AppRoutes.welcome: (context) => const WelcomeScreen(),
        
        // شاشة تسجيل الدخول
        AppRoutes.login: (context) => const LoginScreen(),
        
        // شاشة التسجيل (تم إزالة onSuccess ليتوافق مع التعديل الأخير)
        AppRoutes.signUp: (context) => const SignUpScreen(),
        
        // شاشة النجاح (استقبال الـ arguments لتحديد نوع العملية)
        AppRoutes.success: (context) {
          // القيمة الافتراضية true (أي نجاح تسجيل دخول)
          final isLogin = ModalRoute.of(context)?.settings.arguments as bool? ?? true;
          return SuccessScreen(isLoginSuccess: isLogin);
        },
        
        // شاشتك الرئيسية
        AppRoutes.homePage: (context) => const HomePage(),
            }
            );
            
            },
          );
        },
      ),
    );
  }
}
