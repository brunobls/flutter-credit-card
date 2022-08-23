import 'dart:convert';

class PaymentCardViewModel {
  String type;
  String number;
  String name;
  int expiryMonth;
  int expiryYear;
  String cvv;
  String uuid;

  PaymentCardViewModel({
    required this.type,
    required this.number,
    required this.name,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cvv,
    required this.uuid,
  });

  PaymentCardViewModel copyWith({
    String? type,
    String? number,
    String? name,
    int? expiryMonth,
    int? expiryYear,
    String? cvv,
    String? uuid,
  }) {
    return PaymentCardViewModel(
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
      'type': type,
      'number': number,
      'name': name,
      'expiryMonth': expiryMonth,
      'expiryYear': expiryYear,
      'cvv': cvv,
      'uuid': uuid,
    };
  }

  factory PaymentCardViewModel.fromMap(Map<String, dynamic> map) {
    return PaymentCardViewModel(
      type: map['type'] as String,
      number: map['number'] as String,
      name: map['name'] as String,
      expiryMonth: map['expiryMonth'] as int,
      expiryYear: map['expiryYear'] as int,
      cvv: map['cvv'] as String,
      uuid: map['uuid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentCardViewModel.fromJson(String source) =>
      PaymentCardViewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentCardViewModel(type: $type, number: $number, name: $name, expiryMonth: $expiryMonth, expiryYear: $expiryYear, cvv: $cvv, uuid: $uuid)';
  }

  @override
  bool operator ==(covariant PaymentCardViewModel other) {
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
