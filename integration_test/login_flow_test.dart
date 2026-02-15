import 'package:flutter/material.dart';
import 'package:flutter_deep/interview_test/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Login Flow Integration Tests', () {
    testWidgets('Complete login and payment flow', (WidgetTester tester) async {
      // Launch app
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Verify login screen is displayed
      expect(find.text('Login'), findsOneWidget);
      expect(find.byKey(const Key('email_field')), findsOneWidget);
      expect(find.byKey(const Key('password_field')), findsOneWidget);

      // Enter credentials
      await tester.enterText(
        find.byKey(const Key('email_field')),
        'test@example.com',
      );
      await tester.enterText(
        find.byKey(const Key('password_field')),
        'password123',
      );
      await tester.pumpAndSettle();

      // Tap login button
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();

      // Verify navigation to dashboard
      expect(find.text('Dashboard'), findsOneWidget);
      expect(find.byKey(const Key('dashboard_title')), findsOneWidget);

      // Verify counter widget is present
      expect(find.text('Count: 0'), findsOneWidget);
      expect(find.byKey(const Key('increment_button')), findsOneWidget);

      // Test counter increment
      await tester.tap(find.byKey(const Key('increment_button')));
      await tester.pumpAndSettle();
      expect(find.text('Count: 1'), findsOneWidget);

      // Navigate to payment
      await tester.tap(find.byKey(const Key('make_payment_button')));
      await tester.pumpAndSettle();

      // Verify payment screen
      expect(find.text('Enter Amount'), findsOneWidget);
      expect(find.byKey(const Key('amount_field')), findsOneWidget);

      // Enter amount
      await tester.enterText(find.byKey(const Key('amount_field')), '50.00');
      await tester.pumpAndSettle();

      // Continue to review
      await tester.tap(find.byKey(const Key('continue_button')));
      await tester.pumpAndSettle();

      // Verify review screen
      expect(find.text('Review Payment'), findsOneWidget);
      expect(find.byKey(const Key('review_amount')), findsOneWidget);
      expect(find.byKey(const Key('confirm_button')), findsOneWidget);

      // Confirm payment
      await tester.tap(find.byKey(const Key('confirm_button')));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Verify success screen
      expect(find.text('Payment Successful!'), findsOneWidget);
      expect(find.byKey(const Key('success_icon')), findsOneWidget);
      expect(find.text('\$50.00'), findsOneWidget);

      // Close payment
      await tester.tap(find.byKey(const Key('close_button')));
      await tester.pumpAndSettle();

      // Should return to dashboard
      expect(find.text('Dashboard'), findsOneWidget);
    });

    testWidgets('Invalid login shows error', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Try to login with invalid email
      await tester.enterText(
        find.byKey(const Key('email_field')),
        'invalid-email',
      );
      await tester.enterText(
        find.byKey(const Key('password_field')),
        'password123',
      );
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();

      // Should show error
      expect(find.text('Invalid email format'), findsOneWidget);

      // Should still be on login screen
      expect(find.byKey(const Key('login_button')), findsOneWidget);
    });

    testWidgets('Invalid payment amount shows error', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Login
      await tester.enterText(
        find.byKey(const Key('email_field')),
        'test@example.com',
      );
      await tester.enterText(
        find.byKey(const Key('password_field')),
        'password123',
      );
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();

      // Navigate to payment
      await tester.tap(find.byKey(const Key('make_payment_button')));
      await tester.pumpAndSettle();

      // Try invalid amount
      await tester.enterText(find.byKey(const Key('amount_field')), '0');
      await tester.tap(find.byKey(const Key('continue_button')));
      await tester.pumpAndSettle();

      // Should show error
      expect(
        find.text('Please enter a valid amount greater than 0'),
        findsOneWidget,
      );

      // Should still be on input screen
      expect(find.text('Enter Amount'), findsOneWidget);
    });
  });
}
