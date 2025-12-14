import 'package:flutter/material.dart';
import '../app_theme.dart';
import 'custom_primary_button.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({super.key});

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _selectedRating = 0;

  String get _ratingEmoji {
    switch (_selectedRating) {
      case 1:
        return '😠';
      case 2:
        return '😟';
      case 3:
        return '😐';
      case 4:
        return '🙂';
      case 5:
        return '😍';
      default:
        return '🤔';
    }
  }

  String get _ratingText {
    switch (_selectedRating) {
      case 1:
        return 'Terrible';
      case 2:
        return 'Poor';
      case 3:
        return 'Average';
      case 4:
        return 'Good';
      case 5:
        return 'Excellent';
      default:
        return 'Select a rating';
    }
  }

  Widget _buildStar(int index) {
    final theme = Theme.of(context);
    bool isFilled = index < _selectedRating;
    return IconButton(
      icon: Icon(
        isFilled ? Icons.star : Icons.star_border,
        color: isFilled ? Colors.amber : theme.colorScheme.onSurfaceVariant,
        size: 33,
      ),
      onPressed: () {
        setState(() {
          _selectedRating = index + 1;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
      ),
      contentPadding: const EdgeInsets.all(AppSizes.paddingLarge),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Text(
              'How was your experience?',
              style: AppStyles.titleStyle.copyWith(fontSize: 22),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSizes.paddingMedium),
            Text(
              _ratingEmoji,
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(height: AppSizes.paddingSmall),
            Text(
              _ratingText,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: AppSizes.paddingLarge),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, _buildStar),
            ),
            const SizedBox(height: AppSizes.paddingExtraLarge),
            SizedBox(
              width: double.infinity,
              child: CustomPrimaryButton(
                text: 'Submit Review',
                onPressed: _selectedRating > 0
                    ? () => Navigator.pop(context, _selectedRating)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
