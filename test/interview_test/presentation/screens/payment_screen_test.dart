import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_deep/interview_test/presentation/screens/payment_screen.dart';

void main() {
  group('PaymentScreen', () {
    testWidgets('displays payment input form', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentScreen(),
        ),
      );

      expect(find.byKey(const Key('amount_field')), findsOneWidget);
      expect(find.byKey(const Key('continue_button')), findsOneWidget);
      expect(find.text('Enter Amount'), findsOneWidget);
    });

    testWidgets('shows error for invalid amount', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentScreen(),
        ),
      );

      await tester.tap(find.byKey(const Key('continue_button')));
      await tester.pump();

      expect(find.text('Please enter a valid amount greater than 0'),
          findsOneWidget);
    });

    testWidgets('shows error for zero amount', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentScreen(),
        ),
      );

      await tester.enterText(find.byKey(const Key('amount_field')), '0');
      await tester.tap(find.byKey(const Key('continue_button')));
      await tester.pump();

      expect(find.text('Please enter a valid amount greater than 0'),
          findsOneWidget);
    });

    testWidgets('navigates to review screen with valid amount',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentScreen(),
        ),
      );

      await tester.enterText(find.byKey(const Key('amount_field')), '50.00');
      await tester.tap(find.byKey(const Key('continue_button')));
      await tester.pump();

      expect(find.text('Review Payment'), findsOneWidget);
      expect(find.byKey(const Key('confirm_button')), findsOneWidget);
    });

    testWidgets('shows review amount on review screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentScreen(),
        ),
      );

      await tester.enterText(find.byKey(const Key('amount_field')), '99.99');
      await tester.tap(find.byKey(const Key('continue_button')));
      await tester.pump();

      expect(find.byKey(const Key('review_amount')), findsOneWidget);
    });

    testWidgets('back button returns to input screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentScreen(),
        ),
      );

      await tester.enterText(find.byKey(const Key('amount_field')), '50.00');
      await tester.tap(find.byKey(const Key('continue_button')));
      await tester.pump();

      expect(find.text('Review Payment'), findsOneWidget);

      await tester.tap(find.byKey(const Key('back_button')));
      await tester.pump();

      expect(find.text('Enter Amount'), findsOneWidget);
    });

    testWidgets('confirm button shows loading and processes payment',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentScreen(),
        ),
      );

      await tester.enterText(find.byKey(const Key('amount_field')), '75.50');
      await tester.tap(find.byKey(const Key('continue_button')));
      await tester.pump();

      await tester.tap(find.byKey(const Key('confirm_button')));
      await tester.pump();

      // Wait for payment processing
      await tester.pumpAndSettle();

      expect(find.text('Payment Successful!'), findsOneWidget);
      expect(find.byKey(const Key('success_icon')), findsOneWidget);
    });

    testWidgets('success screen displays amount',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentScreen(),
        ),
      );

      await tester.enterText(find.byKey(const Key('amount_field')), '123.45');
      await tester.tap(find.byKey(const Key('continue_button')));
      await tester.pump();

      await tester.tap(find.byKey(const Key('confirm_button')));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      expect(find.text('\$123.45'), findsOneWidget);
    });
  });
}
