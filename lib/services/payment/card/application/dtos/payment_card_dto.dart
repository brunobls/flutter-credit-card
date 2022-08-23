import 'package:flutter_credit_card/services/payment/card/domain/entities/payment_card_entity.dart';

class PaymentCardDto {
  final CardType type;
  final String number;
  final String name;
  final int expiryMonth;
  final int expiryYear;
  final String cvv;
  final String? uuid;

  PaymentCardDto({
    required this.type,
    required this.number,
    required this.name,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cvv,
    this.uuid,
  });
}
