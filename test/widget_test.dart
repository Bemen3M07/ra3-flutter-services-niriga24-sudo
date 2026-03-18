import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_hello_world/model/car_model.dart';

void main() {
  group('Car model', () {
    test('creates a car from json', () {
      final car = Car.fromJson({
        'id': 9582,
        'year': 2008,
        'make': 'Audi',
        'model': 'A5',
        'type': 'Sedan',
      });

      expect(car.id, 9582);
      expect(car.year, 2008);
      expect(car.make, 'Audi');
      expect(car.model, 'A5');
      expect(car.type, 'Sedan');
    });
  });
}
