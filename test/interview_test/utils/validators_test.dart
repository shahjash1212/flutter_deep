import 'package:flutter_deep/interview_test/utils/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validators', () {
    group('isValidEmail', () {
      test('returns true for valid email', () {
        expect(Validators.isValidEmail('user@example.com'), true);
      });

      test('returns true for valid email with special characters', () {
        expect(Validators.isValidEmail('user.name+tag@example.co.uk'), true);
      });

      test('returns false for email without @', () {
        expect(Validators.isValidEmail('userexample.com'), false);
      });

      test('returns false for email without domain', () {
        expect(Validators.isValidEmail('user@'), false);
      });

      test('returns false for empty email', () {
        expect(Validators.isValidEmail(''), false);
      });

      test('returns false for email with spaces', () {
        expect(Validators.isValidEmail('user @example.com'), false);
      });
    });

    group('isValidAmount', () {
      test('returns true for positive amount', () {
        expect(Validators.isValidAmount(50.0), true);
      });

      test('returns true for small positive amount', () {
        expect(Validators.isValidAmount(0.01), true);
      });

      test('returns false for zero amount', () {
        expect(Validators.isValidAmount(0.0), false);
      });

      test('returns false for negative amount', () {
        expect(Validators.isValidAmount(-10.0), false);
      });

      test('returns false for large negative amount', () {
        expect(Validators.isValidAmount(-1000.0), false);
      });
    });
  });
}
