import 'package:flutter/material.dart';
import 'payment_screen.dart';
import '../widgets/counter_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Dashboard',
                key: const Key('dashboard_title'),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 40),
              const CounterWidget(),
              const SizedBox(height: 40),
              ElevatedButton(
                key: const Key('make_payment_button'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const PaymentScreen()),
                  );
                },
                child: const Text('Make Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
