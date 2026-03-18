import 'package:flutter/material.dart';

import '../page/cars_page.dart';
import 'joke_page.dart';
import 'tmb_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selector d\'exercici'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _ExerciseCard(
                title: 'Llista de cotxes',
                subtitle: 'Obre la llista del servei anterior.',
                icon: Icons.two_wheeler,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CarsPage()),
                  );
                },
              ),
              const SizedBox(height: 12),
              _ExerciseCard(
                title: 'Broma aleatoria',
                subtitle: 'Demana una nova broma cada vegada que prems el boto.',
                icon: Icons.emoji_emotions_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const JokePage()),
                  );
                },
              ),
              const SizedBox(height: 12),
              _ExerciseCard(
                title: 'TMB Api',
                subtitle:
                    'Linies, parades i consulta d\'arribades per codi de parada.',
                icon: Icons.directions_bus_filled_outlined,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TmbPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  const _ExerciseCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Icon(icon, size: 30),
        title: Text(title),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(subtitle),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        onTap: onTap,
      ),
    );
  }
}