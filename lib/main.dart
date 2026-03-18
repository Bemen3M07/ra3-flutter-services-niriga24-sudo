import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/joke_controller.dart';
import 'controller/tmb_controller.dart';
import 'providers/car_provider.dart';
import 'view/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarProvider()),
        ChangeNotifierProvider(create: (_) => JokeController()),
        ChangeNotifierProvider(create: (_) => TmbController()),
      ],
      child: MaterialApp(
        title: 'Exercicis Flutter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        ),
        home: const HomePage(),
      ),
    );
  }
}
