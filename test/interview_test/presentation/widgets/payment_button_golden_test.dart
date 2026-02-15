import 'package:flutter/material.dart';
import 'package:flutter_deep/interview_test/presentation/widgets/payment_button.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaymentButton Golden Tests', () {
    testWidgets('PaymentButton renders correctly', (WidgetTester tester) async {
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      tester.binding.platformDispatcher.views.first.physicalSize = const Size(
        400,
        200,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: PaymentButton(
                amount: 99.99,
                onPressed: () {},
                label: 'Pay',
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(PaymentButton).first,
        matchesGoldenFile('goldens/payment_button.png'),
      );
    });

    testWidgets('PaymentButton with different amounts', (
      WidgetTester tester,
    ) async {
      addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
      tester.binding.platformDispatcher.views.first.physicalSize = const Size(
        400,
        200,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: PaymentButton(
                amount: 999.99,
                onPressed: () {},
                label: 'Purchase',
              ),
            ),
          ),
        ),
      );

      await expectLater(
        find.byType(PaymentButton).first,
        matchesGoldenFile('goldens/payment_button_large.png'),
      );
    });
  });
}
