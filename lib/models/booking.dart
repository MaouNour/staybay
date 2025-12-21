import 'package:staybay/models/apartment_model.dart';

class Booking {
  final Apartment apartment;
  final DateTime checkIn;
  final DateTime checkOut;
  final String bookingId;

  Booking({
    required this.apartment,
    required this.checkIn,
    required this.checkOut,
    required this.bookingId,
  });

  int get nights => checkOut.difference(checkIn).inDays == 0
      ? 1
      : checkOut.difference(checkIn).inDays;

  double get totalPrice => apartment.pricePerNight * nights;
}
