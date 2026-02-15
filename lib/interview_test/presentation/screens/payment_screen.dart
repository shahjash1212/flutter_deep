import 'package:flutter/material.dart';

import '../../data/exceptions/payment_exceptions.dart';
import '../../data/services/payment_service.dart';
import '../../utils/validators.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _paymentService = PaymentService();
  late TextEditingController _amountController;
  String _currentStep = 'input'; // input, review, success
  String? _errorMessage;
  double _amount = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    final amountString = _amountController.text;
    final amount = double.tryParse(amountString);

    if (amount == null || !Validators.isValidAmount(amount)) {
      setState(() {
        _errorMessage = 'Please enter a valid amount greater than 0';
      });
      return;
    }

    setState(() {
      _amount = amount;
      _currentStep = 'review';
      _errorMessage = null;
    });
  }

  Future<void> _handleConfirm() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _paymentService.processPayment(_amount);
      setState(() {
        _currentStep = 'success';
        _isLoading = false;
      });
    } on InvalidAmountException catch (e) {
      setState(() {
        _errorMessage = e.message;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Payment failed';
        _isLoading = false;
      });
    }
  }

  void _handleBackToInput() {
    setState(() {
      _currentStep = 'input';
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Input Step
    if (_currentStep == 'input') {
      return Scaffold(
        appBar: AppBar(title: const Text('Payment')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter Amount',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),
              TextField(
                key: const Key('amount_field'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixText: '\$',
                  hintText: 'Enter amount',
                  border: OutlineInputBorder(),
                ),
              ),
              if (_errorMessage != null) ...[
                const SizedBox(height: 16),
                Text(
                  _errorMessage!,
                  key: const Key('error_text'),
                  style: const TextStyle(color: Colors.red),
                ),
              ],
              const SizedBox(height: 32),
              ElevatedButton(
                key: const Key('continue_button'),
                onPressed: _handleContinue,
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      );
    }

    // Review Step
    if (_currentStep == 'review') {
      return Scaffold(
        appBar: AppBar(title: const Text('Review Payment')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Review Payment',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 32),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Amount:'),
                          Text(
                            '\$${_amount.toStringAsFixed(2)}',
                            key: const Key('review_amount'),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    key: const Key('back_button'),
                    onPressed: _handleBackToInput,
                    child: const Text('Back'),
                  ),
                  ElevatedButton(
                    key: const Key('confirm_button'),
                    onPressed: _isLoading ? null : _handleConfirm,
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Confirm'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    // Success Step
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Success')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              key: Key('success_icon'),
              color: Colors.green,
              size: 80,
            ),
            const SizedBox(height: 24),
            Text(
              'Payment Successful!',
              key: const Key('success_text'),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Text(
              '\$${_amount.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              key: const Key('close_button'),
              onPressed: () =>
                  Navigator.of(context).popUntil((route) => route.isFirst),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
