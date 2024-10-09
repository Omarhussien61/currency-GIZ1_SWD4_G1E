
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/currency_bloc.dart';
import '../../bloc/currency_event.dart';

class CurrencyInputField extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  CurrencyInputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: "Enter amount",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            context.read<CurrencyBloc>().add(FetchRates(baseCurrency: controller.text));
          },
        ),
      ],
    );
  }
}
