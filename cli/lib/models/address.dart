import 'dart:convert';

import 'city.dart';
import 'phone.dart';

class Address {
  String street;
  int number;
  String zipCode;
  City city;
  Phone phone;

  Address({
    required this.street,
    required this.number,
    required this.zipCode,
    required this.city,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'street': street,
      'number': number,
      'zipCode': zipCode,
      'city': city.toMap(),
      'phone': phone.toMap(),
    };
  }

  String toJSON() => jsonEncode(toMap());

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      street: map['street'] ?? '',
      number: map['number'] ?? 0,
      zipCode: map['zipCode'] ?? '',
      city: City.fromMap(map['city'] ?? {}),
      phone: Phone.fromMap(map['phone'] ?? {}),
    );
  }

  factory Address.fromJSON(String json) => Address.fromMap(jsonDecode(json));
}
