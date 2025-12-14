import 'package:flutter/material.dart';
import 'package:staybay/screens/home_page_screen.dart';
import '../app_theme.dart';
import '../services/apartment_service.dart';
import '../models/apartment_model.dart';
import '../widgets/compact_apartment_card.dart';

class FavoritesScreen extends StatefulWidget {
  static const String routeName = '/favorites';
  const FavoritesScreen({super.key});
  
  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final ApartmentService _apartmentService = ApartmentService();
  late Future<List<Apartment>> _favoritesFuture;

  Future<List<Apartment>> _fetchMockFavorites() async {
    final allApartments = await _apartmentService.fetchAllApartments();
    return allApartments;
  }

  @override
  void initState() {
    super.initState();
    _favoritesFuture = _fetchMockFavorites();
  }
  void _goToHome(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      HomePage.routeName, 
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' My Favorites',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: () => _goToHome(context),
        ),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: FutureBuilder<List<Apartment>>(
        future: _favoritesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: theme.colorScheme.primary),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading favorites: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
                  ),
                  const SizedBox(height: AppSizes.paddingMedium),
                  Text(
                    'No Favorite items yet',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            );
          } else {
            final favorites = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(AppSizes.paddingMedium),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return CompactApartmentCard(apartment: favorites[index]); 
              },
            );
          }
        },
      ),
    );
  }
}

