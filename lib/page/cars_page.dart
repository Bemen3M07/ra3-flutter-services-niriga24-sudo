import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/car_provider.dart';
import '../utils/const_app.dart';
import '../widgets/list_cars.dart';

class CarsPage extends StatefulWidget {
  const CarsPage({super.key});

  @override
  State<CarsPage> createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<CarProvider>(context, listen: false).getCarsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cars Catalog'),
      ),
      body: Consumer<CarProvider>(
        builder: (context, value, child) {
          if (value.isLoading && value.carsModel.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (value.carsModel.isNotEmpty) {
            return RefreshIndicator(
              onRefresh: context.read<CarProvider>().getCarsData,
              child: ListCars(
                cars: context.watch<CarProvider>().carsModel,
              ),
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(messageErrorCarsApi),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: context.read<CarProvider>().getCarsData,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
