import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_theme.dart';

import 'cubits/locale/locale_state.dart';
import 'cubits/locale/locale_cubit.dart';
import 'cubits/theme/theme_cubit.dart'; 
import 'cubits/theme/theme_state.dart'; 

import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/success_screen.dart';
import 'screens/home_page_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      //themeMode: ThemeMode.light,
      
      initialRoute: WelcomeScreen.routeName, 
      
      routes: {
        WelcomeScreen.routeName: (context) => const WelcomeScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        HomePage.routeName: (context) => const HomePage(),

        SuccessScreen.routeName: (context) {
          final isLogin = ModalRoute.of(context)?.settings.arguments as bool? ?? true;
          return SuccessScreen(isLoginSuccess: isLogin);
        },
      },
    );
  }
}


