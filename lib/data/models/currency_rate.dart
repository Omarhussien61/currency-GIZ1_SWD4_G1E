class CurrencyRate {
  final String baseCode;
  final Map<String, double> rates;

  CurrencyRate({required this.baseCode, required this.rates});

  factory CurrencyRate.fromJson(Map<String, dynamic> json) {
    return CurrencyRate(
      baseCode: json['base_code'],
      rates: Map<String, double>.from(json['conversion_rates']),
    );
  }
}
