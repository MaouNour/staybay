
import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'screens/welcome_screen.dart'; 
import 'screens/login_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/home_page_screen.dart';
import 'screens/add_apartment_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/account_screen.dart';
import 'screens/success_screen.dart';
import 'screens/apartment_details_screen.dart';  
import 'screens/my_bookings_screen.dart'; 
import '../models/apartment_model.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'STAY BAY',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      //themeMode: ThemeMode.system, 
      themeMode: ThemeMode.light, 
      initialRoute: WelcomeScreen.routeName, 
      
      routes: {
        WelcomeScreen.routeName: (context) => const WelcomeScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),  
        HomePage.routeName: (context) => const HomePage(),
        AddApartmentScreen.routeName: (context) => const AddApartmentScreen(),   
        FavoritesScreen.routeName: (context) => const FavoritesScreen(),   
        AccountScreen.routeName: (context) => const AccountScreen(),  
        MyBookingsScreen.routeName: (context) => const MyBookingsScreen(), 
        SuccessScreen.routeName: (context) {
          final isLogin = ModalRoute.of(context)?.settings.arguments as bool? ?? true;
          return SuccessScreen(isLoginSuccess: isLogin);
        },
            ApartmentDetailsScreen.routeName: (context) {
              final apartment = ModalRoute.of(context)?.settings.arguments as Apartment?;
              if (apartment == null) {
                return const Scaffold(body: Center(child: Text('Error: Apartment details missing.')));
              }
              return ApartmentDetailsScreen(apartment: apartment); 
         },
       },
     );
   }
 }
