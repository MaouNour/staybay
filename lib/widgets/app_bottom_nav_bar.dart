import 'package:flutter/material.dart';
import '../app_theme.dart';
import '../screens/home_page_screen.dart'; 
import '../screens/add_apartment_screen.dart'; 
import '../screens/favorites_screen.dart'; 
import '../screens/account_screen.dart'; 

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    void onItemSelected(int index) {
      String route = HomePage.routeName;
      switch (index) {
        case 0:
          route = HomePage.routeName; 
          break;
        case 1: 
          route = AddApartmentScreen.routeName; 
          break;
        case 2:
          route = FavoritesScreen.routeName;
          break;
        case 3:
          route = AccountScreen.routeName;
          break;
      }
      if (index != currentIndex) {
        Navigator.of(context).pushReplacementNamed(route);
      }
    }
    final Color activeColor = theme.colorScheme.onPrimary;
    final Color inactiveColor = activeColor.withOpacity(0.7);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onItemSelected,
      
      backgroundColor: theme.colorScheme.primary, 
      
      type: BottomNavigationBarType.fixed,
      
      selectedItemColor: activeColor, 
      unselectedItemColor: inactiveColor, 
      
      selectedLabelStyle: AppStyles.labelStyle.copyWith(
        fontSize: AppSizes.fontSizeLabel * 0.9,
        color: activeColor,
      ),
      unselectedLabelStyle: AppStyles.labelStyle.copyWith(
        fontSize: AppSizes.fontSizeLabel * 0.9,
        color: inactiveColor,
      ),

      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle_outline),
          activeIcon: Icon(Icons.add_circle),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          activeIcon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Account',
        ),
      ],
    );
  }
}