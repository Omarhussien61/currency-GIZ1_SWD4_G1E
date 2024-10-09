abstract class CurrencyState {}

class CurrencyInitial extends CurrencyState {}

class CurrencyLoading extends CurrencyState {}

class CurrencyLoaded extends CurrencyState {
  final Map<String, double> rates;
  final List<String> targetCurrencies;

  CurrencyLoaded({required this.rates, required this.targetCurrencies});
}

class CurrencyError extends CurrencyState {
  final String message;

  CurrencyError({required this.message});
}
