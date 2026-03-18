import 'dart:convert';

class Car {
  final int id;
  final int year;
  final String make;
  final String model;
  final String type;

  const Car({
    required this.id,
    required this.year,
    required this.make,
    required this.model,
    required this.type,
  });

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json['id'] as int? ?? 0,
        year: json['year'] as int? ?? 0,
        make: json['make']?.toString() ?? '',
        model: json['model']?.toString() ?? '',
        type: json['type']?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'year': year,
        'make': make,
        'model': model,
        'type': type,
      };

  static List<Car> listFromJson(String listJson) {
    final decoded = json.decode(listJson) as List<dynamic>;
    return decoded
        .map((item) => Car.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  static String listToJson(List<Car> cars) {
    return json.encode(
      cars.map((car) => car.toJson()).toList(),
    );
  }
}
