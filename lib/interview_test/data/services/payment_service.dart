import '../exceptions/payment_exceptions.dart';
import '../models/user_model.dart';

abstract class IPaymentService {
  Future<Map<String, dynamic>> processPayment(double amount);
}

class PaymentService implements IPaymentService {
  @override
  Future<Map<String, dynamic>> processPayment(double amount) async {
    if (amount <= 0) {
      throw InvalidAmountException('Amount must be greater than 0');
    }

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Return success response
    return {
      'success': true,
      'transactionId': 'TXN_${DateTime.now().millisecondsSinceEpoch}',
      'amount': amount,
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
}
