import 'package:flutter/material.dart';
import '../../models/apartment_model.dart';
import '../app_theme.dart';
import '../widgets/custom_primary_button.dart';
import '../widgets/custom_text_field.dart';
import 'my_bookings_screen.dart';

class BookingDetailsScreen extends StatefulWidget {
  static const String routeName = '/booking';
  const BookingDetailsScreen({super.key});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  String? _selectedPaymentMethod;
  double _pricePerNight = 0.0;

  final TextEditingController _checkInController = TextEditingController();
  final TextEditingController _checkOutController = TextEditingController();

  final List<String> _paymentMethods = [
    'PayPal',
    'Cash ',
    'Bank Transfer',
    'Credit Card',
  ];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final apartment = ModalRoute.of(context)?.settings.arguments as Apartment?;
    if (apartment != null) {
      _pricePerNight = apartment.pricePerNight;
    }
  }

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final theme = Theme.of(context);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _checkInDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: theme.colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkInDate = picked;
          _checkInController.text = _formatDate(picked);
          if (_checkOutDate != null &&
              (_checkOutDate!.isBefore(_checkInDate!) ||
                  _checkOutDate!.isAtSameMomentAs(_checkInDate!))) {
            _checkOutDate = _checkInDate!.add(const Duration(days: 1));
            _checkOutController.text = _formatDate(_checkOutDate);
          }
        } else if (_checkInDate != null && picked.isAfter(_checkInDate!)) {
          _checkOutDate = picked;
          _checkOutController.text = _formatDate(picked);
        } else if (_checkInDate == null) {
          _checkOutDate = picked;
          _checkOutController.text = _formatDate(picked);
        }
      });
    }
  }

  int get _numberOfNights {
    if (_checkInDate != null && _checkOutDate != null) {
      final difference = _checkOutDate!.difference(_checkInDate!).inDays;
      return difference > 0 ? difference : 0;
    }
    return 0;
  }

  double get _totalPrice {
    return _numberOfNights * _pricePerNight;
  }

  void _confirmBooking() {
    if (_checkInDate == null ||
        _checkOutDate == null ||
        _selectedPaymentMethod == null ||
        _numberOfNights == 0 ||
        _pricePerNight == 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select valid dates, payment method, and ensure apartment price is loaded.',
          ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Booking processed! Navigating to My Bookings...'),
      ),
    );

    Navigator.of(context).pushNamed(MyBookingsScreen.routeName);
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Select Date';
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _checkInController.dispose();
    _checkOutController.dispose();
    super.dispose();
  }

  Widget _buildThemedField(Widget fieldContent) {
    final theme = Theme.of(context);
    final primaryColorWithAlpha30 = theme.colorScheme.primary.withAlpha(
      77,
    ); // تقريبا 30%
    final primaryColorWithAlpha10 = theme.colorScheme.primary.withAlpha(
      25,
    ); // تقريبا 10%

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.paddingMedium,
        vertical: AppSizes.paddingSmall * 0.5,
      ),
      decoration: BoxDecoration(
        color: primaryColorWithAlpha10,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
        border: Border.all(color: primaryColorWithAlpha30, width: 1.0),
      ),
      child: fieldContent,
    );
  }

  Widget _buildPriceField(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColorWithAlpha10 = theme.colorScheme.primary.withAlpha(25);
    final primaryColorWithAlpha30 = theme.colorScheme.primary.withAlpha(77);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.paddingMedium),
      decoration: BoxDecoration(
        color: primaryColorWithAlpha10,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLarge),
        border: Border.all(color: primaryColorWithAlpha30),
      ),
      child: Text(
        '\$${_totalPrice.toStringAsFixed(2)}',
        style: theme.textTheme.headlineSmall?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final inputDataStyle = theme.textTheme.titleLarge?.copyWith(
      fontWeight: FontWeight.normal,
      color: theme.colorScheme.onSurface,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingLarge,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  'Booking Details',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: primaryColor,
                    fontSize: 32,
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.paddingExtraLarge),
              Text(
                'Check-in Date :',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSizes.paddingSmall * 0.5),
              _buildThemedField(
                CustomTextField(
                  controller: _checkInController,
                  hintText: _formatDate(_checkInDate),
                  readOnly: true,
                  onTap: () => _selectDate(context, true),
                  // textStyle: inputDataStyle,
                  // decoration: InputDecoration(
                  //   hintText: _formatDate(_checkInDate),
                  //   suffixIcon: Icon(Icons.calendar_today, color: primaryColor, size: 28),
                  //   border: InputBorder.none,
                  //   focusedBorder: InputBorder.none,
                  //   enabledBorder: InputBorder.none,
                  //  // contentPadding: EdgeInsets.zero,
                  //  contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                  // ),
                ),
              ),
              const SizedBox(height: AppSizes.paddingMedium),
              Text(
                'Check-out Date :',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSizes.paddingSmall * 0.5),
              _buildThemedField(
                CustomTextField(
                  controller: _checkOutController,
                  hintText: _formatDate(_checkOutDate),
                  readOnly: true,
                  onTap: _checkInDate != null
                      ? () => _selectDate(context, false)
                      : null,
                  // textStyle: inputDataStyle,
                  // decoration: InputDecoration(
                  //   hintText: _formatDate(_checkOutDate),
                  //   suffixIcon: Icon(Icons.calendar_today, color: primaryColor, size: 28),
                  //   border: InputBorder.none,
                  //   focusedBorder: InputBorder.none,
                  //   enabledBorder: InputBorder.none,
                  //   //contentPadding: EdgeInsets.zero,
                  //   contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                  // ),
                ),
              ),
              const SizedBox(height: AppSizes.paddingMedium),
              Text(
                'Payment Method:',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSizes.paddingSmall * 0.5),
              _buildThemedField(
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text('Select Payment Option', style: inputDataStyle),
                    value: _selectedPaymentMethod,
                    items: _paymentMethods.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: inputDataStyle),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedPaymentMethod = newValue;
                      });
                    },
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: primaryColor,
                      size: 28,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.paddingExtraLarge),
              Text(
                'Total Price ( ${_numberOfNights} nights):',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSizes.paddingSmall),
              _buildPriceField(context),
              const SizedBox(height: AppSizes.paddingExtraLarge * 1.5),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppSizes.paddingLarge),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(12),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SizedBox(
          height: AppSizes.buttonHeight,
          child: CustomPrimaryButton(
            text: 'Confirm and Book Now',
            onPressed: _totalPrice > 0 && _selectedPaymentMethod != null
                ? _confirmBooking
                : null,
          ),
        ),
      ),
    );
  }
}
