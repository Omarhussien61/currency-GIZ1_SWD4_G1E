import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/currency_bloc.dart';
import '../../bloc/currency_event.dart';

class CurrencyListScreen extends StatelessWidget {
  final List<String> availableCurrencies;

  const CurrencyListScreen({super.key, required this.availableCurrencies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Currency")),
      body: ListView.builder(
        itemCount: availableCurrencies.length,
        itemBuilder: (context, index) {
          final currency = availableCurrencies[index];
          return ListTile(
            title: Text(currency),
            onTap: () {
              context.read<CurrencyBloc>().add(AddTargetCurrency(currency: currency));
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
