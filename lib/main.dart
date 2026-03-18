import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'page/cars_page.dart';
import 'providers/car_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CarProvider(),
      child: MaterialApp(
        title: 'Rent Cars',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const CarsPage()
      ),
    );
  }
}
