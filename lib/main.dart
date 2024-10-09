import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myapp/bloc/currency_bloc.dart';
import 'package:myapp/data/currency_repository.dart';
import 'package:myapp/ui/screens/home_screen.dart';

void main() {
  runApp(CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  const CurrencyConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => CurrencyBloc(
          repository: CurrencyRepository(),
        ),
        child: HomeScreen(), 
      ),
    );
  }
}
