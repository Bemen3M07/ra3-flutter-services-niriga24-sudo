import 'package:flutter/material.dart';
import '../model/car_model.dart';

class ListCars extends StatelessWidget {
  const ListCars({
    super.key,
    required this.cars,
  });

  final List<Car> cars;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: cars.length + 1,
      separatorBuilder: (_, index) => index == 0
          ? const SizedBox(height: 10)
          : const SizedBox(height: 12),
      itemBuilder: (context, index) {
        if (index == 0) {
          return const SizedBox(
            height: 56,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All Cars',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.filter_list_alt),
              ],
            ),
          );
        }

        final car = cars[index - 1];
        return _CarCard(car: car);
      },
    );
  }
}

class _CarCard extends StatelessWidget {
  const _CarCard({required this.car});

  final Car car;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${car.make} ${car.model}',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _CarInfoChip(label: 'ID', value: '${car.id}'),
                _CarInfoChip(label: 'Year', value: '${car.year}'),
                _CarInfoChip(label: 'Type', value: car.type),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CarInfoChip extends StatelessWidget {
  const _CarInfoChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text('$label: $value'),
    );
  }
}
