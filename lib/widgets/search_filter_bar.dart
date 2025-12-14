import 'package:flutter/material.dart';
import '../app_theme.dart';
import 'custom_text_field.dart';

class SearchFilterBar extends StatelessWidget {
  final TextEditingController searchController;

  const SearchFilterBar({super.key, required this.searchController});

  static const List<String> syrianGovernorates = [
    'Damascus', 'Rif Dimashq', 'Quneitra', 'Daraa', 
    'Sweida', 'Homs', 'Hama', 'Tartous', 
    'Latakia', 'Idlib', 'Aleppo', 'Raqqa', 
    'Deir ez-Zor', 'Al-Hasakah' 
  ];

  void _showLocationFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.borderRadiusLarge)),
      ),
      builder: (context) {
        final theme = Theme.of(context);
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSizes.paddingMedium),
                child: Text(
                  'Select Location (Governorate)',
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: syrianGovernorates.length,
                  itemBuilder: (context, index) {
                    final location = syrianGovernorates[index];
                    return ListTile(
                      title: Text(location, style: theme.textTheme.titleMedium),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Filtering by: $location')),
                        );
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  void _showPriceFilter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSizes.borderRadiusLarge)),
      ),
      builder: (context) {
        final theme = Theme.of(context);
        const List<String> priceRanges = ['<\$500', '\$500 - \$1000', '\$1000 - \$2000', '>\$2000'];
        return Container(
          padding: const EdgeInsets.all(AppSizes.paddingLarge),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Price Range',
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppSizes.paddingMedium),
              ...priceRanges.map((range) => Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSizes.paddingSmall),
                child: InkWell(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Filtering by price range: $range')),
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(AppSizes.paddingMedium),
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.colorScheme.outline),
                      borderRadius: BorderRadius.circular(AppSizes.borderRadiusSmall),
                    ),
                    width: double.infinity,
                    child: Text(range, style: theme.textTheme.titleMedium),
                  ),
                ),
              )).toList(),
              const SizedBox(height: AppSizes.paddingSmall),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterButton(BuildContext context, {required String label, required IconData icon, required VoidCallback onTap}) {
    final theme = Theme.of(context);
    return Expanded(
      child: Container(
        height: 48,
        margin: const EdgeInsets.symmetric(horizontal: AppSizes.paddingSmall / 2),
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.outline, width: 1.5),
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMedium),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: AppSizes.paddingSmall),
                Text(
                  label,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, size: 20, color: theme.colorScheme.onSurface),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMedium),
          child: CustomTextField(
            controller: searchController,
            hintText: 'Search by location, price, or keywords',
            maxLength: 50,
            suffixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ),

        const SizedBox(height: AppSizes.paddingMedium),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMedium),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFilterButton(
                context, 
                label: 'Location', 
                icon: Icons.location_on_outlined,
                onTap: () => _showLocationFilter(context),
              ),
              _buildFilterButton(
                context, 
                label: 'Price', 
                icon: Icons.attach_money,
                onTap: () => _showPriceFilter(context),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.paddingMedium),
      ],
    );
  }
}