import 'dart:convert';

class Phone {
  final int ddd;
  final String number;

  Phone({
    required this.ddd,
    required this.number,
  });

  Map<String, dynamic> toMap() {
    return {
      'ddd': ddd,
      'number': number,
    };
  }

  String toJSON() => jsonEncode(toMap());

  factory Phone.fromMap(Map<String, dynamic> map) {
    return Phone(
      ddd: map['id'] ?? 0,
      number: map['number'] ?? '',
    );
  }

  factory Phone.fromJSON(String json) => Phone.fromMap(jsonDecode(json));
}
