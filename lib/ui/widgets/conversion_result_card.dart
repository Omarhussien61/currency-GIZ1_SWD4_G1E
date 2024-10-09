import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConversionResultCard extends StatelessWidget {
  final String currency;
  final double rate;
  final double convertedAmount;

  const ConversionResultCard({
    Key? key,
    required this.currency,
    required this.rate,
    required this.convertedAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on),
        title: Text('$convertedAmount $currency'),
        subtitle: Text('Rate: $rate'),
      ),
    );
  }
}

// CurrencyInputField widget for user input
class CurrencyInputField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const CurrencyInputField({Key? key, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: "Insert Amount"),
      onChanged: onChanged,
    );
  }
}