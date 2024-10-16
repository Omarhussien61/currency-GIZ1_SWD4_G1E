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
      debugShowCheckedModeBanner: false,
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        dropdownMenuTheme: DropdownMenuThemeData(
          textStyle: TextStyle(color: Colors.white),
          menuStyle: MenuStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
          ),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
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
