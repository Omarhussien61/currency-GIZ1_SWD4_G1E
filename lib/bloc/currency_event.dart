abstract class CurrencyEvent {}

class FetchRates extends CurrencyEvent {
  final String baseCurrency;

  FetchRates({required this.baseCurrency});
}

class AddTargetCurrency extends CurrencyEvent {
  final String currency;

  AddTargetCurrency({required this.currency});
}

class RemoveTargetCurrency extends CurrencyEvent {
  final String currency;

  RemoveTargetCurrency({required this.currency});
}
