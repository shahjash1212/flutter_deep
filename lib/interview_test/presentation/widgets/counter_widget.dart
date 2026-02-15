import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/counter_provider.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Consumer<CounterProvider>(
          builder: (context, counter, _) {
            return Text(
              'Count: ${counter.count}',
              style: Theme.of(context).textTheme.headlineMedium,
              key: const Key('count_text'),
            );
          },
        ),
        const SizedBox(height: 20),
        Consumer<CounterProvider>(
          builder: (context, counter, _) {
            return ElevatedButton(
              key: const Key('increment_button'),
              onPressed: () => counter.increment(),
              child: const Text('Increment'),
            );
          },
        ),
      ],
    );
  }
}
