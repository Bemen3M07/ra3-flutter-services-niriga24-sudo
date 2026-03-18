import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/joke_controller.dart';

class JokePage extends StatefulWidget {
  const JokePage({super.key});

  @override
  State<JokePage> createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<JokeController>().loadRandomJoke();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acudit Aleatori'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<JokeController>(
            builder: (context, controller, _) {
              if (controller.isLoading && controller.currentJoke == null) {
                return const CircularProgressIndicator();
              }

              if (controller.errorMessage != null) {
                return _JokeError(
                  message: controller.errorMessage!,
                  onRetry: controller.loadRandomJoke,
                );
              }

              final joke = controller.currentJoke;
              if (joke == null) {
                return _JokeError(
                  message: 'No hi ha cap acudit disponible.',
                  onRetry: controller.loadRandomJoke,
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            joke.setup,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 14),
                          Text(
                            joke.punchline,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: controller.isLoading
                        ? null
                        : controller.loadRandomJoke,
                    icon: controller.isLoading
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.casino_outlined),
                    label: const Text('Nou acudit'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _JokeError extends StatelessWidget {
  const _JokeError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: onRetry,
          child: const Text('Tornar-ho a provar'),
        ),
      ],
    );
  }
}