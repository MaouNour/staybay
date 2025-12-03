import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'screens/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StayBay Dream House',
      
      theme: AppTheme.darkTheme,
      //theme: AppTheme.lightTheme,

      home: const WelcomeScreen(), 
      
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_theme.dart';

import 'cubits/locale/locale_state.dart';
import 'cubits/locale/locale_cubit.dart';
import 'cubits/theme/theme_cubit.dart'; 
import 'cubits/theme/theme_state.dart'; 

// import 'screens/welcome_screen.dart';
// import 'screens/login_screen.dart';
// import 'screens/sign_up_screen.dart';
// import 'screens/success_screen.dart';
// import 'screens/home_page_screen.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
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
                title: 'test', 

                builder: (context, child) {
                  return Directionality(
                    textDirection: loctalestate.textDirection,
                    child: child!,
                  );
                },
                
                theme: AppTheme.lightTheme,
                
                darkTheme: AppTheme.darkTheme,
                
                themeMode: themestate is DarkModeState
                    ? ThemeMode.dark
                    : ThemeMode.light,
                
                initialRoute: AppRoutes.welcome,

                // routes: {
                //   AppRoutes.welcome: (context) => const WelcomeScreen(),
                  
                //   AppRoutes.login: (context) => const LoginScreen(),
                  
                //   AppRoutes.signUp: (context) => const SignUpScreen(),
                  
                //   AppRoutes.success: (context) {
                  
                //     final isLogin = ModalRoute.of(context)?.settings.arguments as bool? ?? true;
                //     return SuccessScreen(isLoginSuccess: isLogin);
                //   },
                  
                //   AppRoutes.homePage: (context) => const HomePage(),   
                }
              );
            },
          );
        },
      ),
    );
  }
}*/
