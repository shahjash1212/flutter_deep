class InvalidAmountException implements Exception {
  final String message;

  InvalidAmountException(this.message);

  @override
  String toString() => 'InvalidAmountException: $message';
}

class PaymentException implements Exception {
  final String message;

  PaymentException(this.message);

  @override
  String toString() => 'PaymentException: $message';
}
