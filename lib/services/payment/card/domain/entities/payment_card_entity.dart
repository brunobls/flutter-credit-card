// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

class PaymentCardEntity {
  CardType? type;
  CardNumber? number;
  String? name;
  int? expiryMonth;
  int? expiryYear;
  String? cvv;
  String? uuid;

  PaymentCardEntity({
    this.type,
    this.number,
    this.name,
    this.expiryMonth,
    this.expiryYear,
    this.cvv,
    this.uuid,
  }) {
    uuid ??= const Uuid().v4();
  }

  Either<Map<String, dynamic>, bool> isValid() {
    Map<String, String> invalids = {};

    if (type == null) {
      invalids.addAll({'type': 'Type is required'});
    } else if (type == CardType.invalid) {
      invalids.addAll({'type': 'Type is invalid'});
    }

    if (number == null) {
      invalids.addAll({'number': 'Number is required'});
    } else {
      number?.isValid().fold((l) => invalids.addAll(l), (r) => null);
    }

    if (name == null) {
      invalids.addAll({'name': 'Name is required'});
    } else if (name!.length < 2) {
      invalids.addAll({'name': 'Name must be at least 2 characters'});
    } else if (name!.length > 50) {
      invalids.addAll({'name': 'Name must be at most 50 characters'});
    }

    if (expiryMonth == null) {
      invalids.addAll({'expiryMonth': 'Expiry month is required'});
    } else if (expiryMonth! < 1 || expiryMonth! > 12) {
      invalids.addAll({'expiryMonth': 'Expiry month must be between 1 and 12'});
    }

    if (expiryYear == null) {
      invalids.addAll({'expiryYear': 'Expiry year is required'});
    } else if (expiryYear! < DateTime.now().year) {
      invalids.addAll({'expiryYear': 'Expiry year must be in the future'});
    }

    if (cvv == null) {
      invalids.addAll({'cvv': 'CVV is required'});
    } else if (cvv!.length < 3 || cvv!.length > 4) {
      invalids.addAll({'cvv': 'CVV must be 3 or 4 digits'});
    }

    return invalids.isEmpty
        ? const Right(true)
        : Left({'invalid-entity': invalids});
  }

  static CardType getCardTypeFromNumber(String number) {
    CardType cardType;
    if (number.startsWith(RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CardType.master;
    } else if (number.startsWith(RegExp(r'[4]'))) {
      cardType = CardType.visa;
    } else if (number.length <= 8) {
      cardType = CardType.others;
    } else {
      cardType = CardType.invalid;
    }
    return cardType;
  }

  PaymentCardEntity copyWith({
    CardType? type,
    CardNumber? number,
    String? name,
    int? expiryMonth,
    int? expiryYear,
    String? cvv,
    String? uuid,
  }) {
    return PaymentCardEntity(
      type: type ?? this.type,
      number: number ?? this.number,
      name: name ?? this.name,
      expiryMonth: expiryMonth ?? this.expiryMonth,
      expiryYear: expiryYear ?? this.expiryYear,
      cvv: cvv ?? this.cvv,
      uuid: uuid ?? this.uuid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type != null ? type!.name : '',
      'number': number,
      'name': name,
      'expiryMonth': expiryMonth,
      'expiryYear': expiryYear,
      'cvv': cvv,
      'uuid': uuid,
    };
  }

  factory PaymentCardEntity.fromMap(Map<String, dynamic> map) {
    return PaymentCardEntity(
      type: map['type'] != null ? CardType.fromString(map['type']) : null,
      number: map['number'] != null
          ? CardNumber(number: map['number'].toString())
          : null,
      name: map['name'] != null ? map['name'] as String : null,
      expiryMonth:
          map['expiryMonth'] != null ? map['expiryMonth'] as int : null,
      expiryYear: map['expiryYear'] != null ? map['expiryYear'] as int : null,
      cvv: map['cvv'] != null ? map['cvv'] as String : null,
      uuid: map['uuid'] != null ? map['uuid'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentCardEntity.fromJson(String source) =>
      PaymentCardEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentCardEntity(type: $type, number: $number, name: $name, expiryMonth: $expiryMonth, expiryYear: $expiryYear, cvv: $cvv, uuid: $uuid)';
  }

  @override
  bool operator ==(covariant PaymentCardEntity other) {
    if (identical(this, other)) return true;

    return other.type == type &&
        other.number == number &&
        other.name == name &&
        other.expiryMonth == expiryMonth &&
        other.expiryYear == expiryYear &&
        other.cvv == cvv &&
        other.uuid == uuid;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        number.hashCode ^
        name.hashCode ^
        expiryMonth.hashCode ^
        expiryYear.hashCode ^
        cvv.hashCode ^
        uuid.hashCode;
  }
}

class CardNumber {
  String number;

  CardNumber({
    required this.number,
  });

  String getCleanedNumber(String number) {
    RegExp regExp = RegExp(r"[^0-9]");
    return number.replaceAll(regExp, '');
  }

  Either<Map<String, String>, bool> isValid() {
    if (number.isEmpty) {
      return const Left({'number': 'Number is required'});
    }

    number = getCleanedNumber(number);

    if (number.length < 8) {
      return const Left({'number': 'Card is invalid'});
    }

    /// With the card number with Luhn Algorithm
    /// https://en.wikipedia.org/wiki/Luhn_algorithm
    int sum = 0;
    int length = number.length;
    for (var i = 0; i < length; i++) {
      // get digits in reverse order
      int digit = int.parse(number[length - i - 1]);

      // every 2nd number multiply with 2
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }

    if (sum % 10 == 0) {
      return const Right(true);
    }

    return const Left({'number': 'Card is invalid'});
  }
}

enum CardType {
  master('Master'),
  visa('Visa'),
  others('Others'),
  invalid('Invalid');

  final String name;
  const CardType(this.name);

  static CardType fromString(String value) {
    switch (value) {
      case 'Master':
        return CardType.master;
      case 'Visa':
        return CardType.visa;
      case 'Others':
        return CardType.others;
      case 'Invalid':
        return CardType.invalid;
      default:
        return CardType.invalid;
    }
  }
}
