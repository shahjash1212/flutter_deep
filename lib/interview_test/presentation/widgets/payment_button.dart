import 'package:flutter/material.dart';

class PaymentButton extends StatelessWidget {
  final double amount;
  final VoidCallback onPressed;
  final String label;

  const PaymentButton({
    super.key,
    required this.amount,
    required this.onPressed,
    this.label = 'Pay',
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: const Key('payment_button'),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
      child: Text(
        '$label \$${amount.toStringAsFixed(2)}',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
