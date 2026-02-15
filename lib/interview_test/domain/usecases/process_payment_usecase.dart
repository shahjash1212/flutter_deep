import '../../data/services/payment_service.dart';

abstract class IProcessPaymentUseCase {
  Future<Map<String, dynamic>> call(double amount);
}

class ProcessPaymentUseCase implements IProcessPaymentUseCase {
  final IPaymentService paymentService;

  ProcessPaymentUseCase(this.paymentService);

  @override
  Future<Map<String, dynamic>> call(double amount) async {
    return paymentService.processPayment(amount);
  }
}
