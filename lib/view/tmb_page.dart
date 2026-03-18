import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/tmb_controller.dart';
import '../utils/const_app.dart';

class TmbPage extends StatefulWidget {
  const TmbPage({super.key});

  @override
  State<TmbPage> createState() => _TmbPageState();
}

class _TmbPageState extends State<TmbPage> {
  final _stopCodeController = TextEditingController();

  @override
  void dispose() {
    _stopCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TMB Open Data')),
      body: Consumer<TmbController>(
        builder: (context, controller, _) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Serveis TMB (3 endpoints)',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Endpoint linies configurat: $tmbBusLinesEndpoint',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  FilledButton(
                    onPressed:
                        controller.isLoadingLines ? null : controller.loadBusLines,
                    child: const Text('Carregar linies bus'),
                  ),
                  FilledButton.tonal(
                    onPressed: controller.isLoadingStops ? null : controller.loadStops,
                    child: const Text('Carregar parades'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _stopCodeController,
                decoration: const InputDecoration(
                  labelText: 'Codi de parada',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              FilledButton.icon(
                onPressed: controller.isLoadingArrivals
                    ? null
                    : () {
                        final code = _stopCodeController.text.trim();
                        if (code.isEmpty) return;
                        controller.loadArrivalsByStopCode(code);
                      },
                icon: const Icon(Icons.search),
                label: const Text('Consultar busos que han de passar'),
              ),
              const SizedBox(height: 16),
              if (controller.errorMessage != null && controller.arrivals.isEmpty)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          controller.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              if (controller.lines.isNotEmpty) ...[
                const SizedBox(height: 8),
                _CounterPill(
                  icon: Icons.route,
                  label: 'Linies carregades',
                  value: controller.lines.length.toString(),
                ),
              ],
              if (controller.stops.isNotEmpty) ...[
                const SizedBox(height: 8),
                _CounterPill(
                  icon: Icons.pin_drop,
                  label: 'Parades carregades',
                  value: controller.stops.length.toString(),
                ),
              ],
              if (controller.arrivals.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text(
                  'Arribades previstes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...controller.arrivals.map(
                  (item) => Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(item.line),
                      ),
                      title: Text(item.destination),
                      subtitle: const Text('Temps estimat d\'arribada'),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '${item.minutes} min',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _CounterPill extends StatelessWidget {
  const _CounterPill({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 8),
          Text('$label: $value'),
        ],
      ),
    );
  }
}