part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class CreatePaymentIntentEvent extends PaymentEvent{
  final int amount;
  final String currency;

  const CreatePaymentIntentEvent(this.amount, this.currency);

  @override
  List<Object> get props => [amount, currency];
}

class MakePaymentEvent extends PaymentEvent{
  final String secrete;

  const MakePaymentEvent(this.secrete);

  @override
  List<Object> get props => [secrete];
}
