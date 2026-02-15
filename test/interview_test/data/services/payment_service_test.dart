import 'package:flutter_deep/interview_test/data/exceptions/payment_exceptions.dart';
import 'package:flutter_deep/interview_test/data/services/payment_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaymentService', () {
    late PaymentService paymentService;

    setUp(() {
      paymentService = PaymentService();
    });

    group('processPayment', () {
      test('returns success response for valid amount', () async {
        final result = await paymentService.processPayment(100.0);

        expect(result['success'], true);
        expect(result['amount'], 100.0);
        expect(result['transactionId'], isNotEmpty);
        expect(result['timestamp'], isNotEmpty);
      });

      test('throws InvalidAmountException for zero amount', () async {
        expect(
          () => paymentService.processPayment(0.0),
          throwsA(isA<InvalidAmountException>()),
        );
      });

      test('throws InvalidAmountException for negative amount', () async {
        expect(
          () => paymentService.processPayment(-50.0),
          throwsA(isA<InvalidAmountException>()),
        );
      });

      test('returns unique transaction IDs for consecutive calls', () async {
        final result1 = await paymentService.processPayment(50.0);
        final result2 = await paymentService.processPayment(75.0);

        expect(result1['transactionId'], isNot(result2['transactionId']));
      });

      test('transaction includes correct amount', () async {
        const testAmount = 123.45;
        final result = await paymentService.processPayment(testAmount);

        expect(result['amount'], testAmount);
      });
    });
  });
}
