import 'package:flutter/material.dart';
import 'dart:convert'; // For decoding JSON
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _targetCurrencies = [];
  String _selectedCurrency = 'USD'; // Default selected currency
  double _inputAmount = 0.0;
  double? _convertedAmount;

  // Store the conversion rates map
  final Map<String, double> conversionRates = {
    "USD": 1,
    "AED": 3.6725,
    "AFN": 68.1414,
    "ALL": 89.9559,
    "AMD": 386.9372,
    "ANG": 1.7900,
    "AOA": 920.5228,
    "ARS": 975.9200,
    "AUD": 1.4840,
    "AWG": 1.7900,
    "AZN": 1.7005,
    "BAM": 1.7822,
    "BBD": 2.0000,
    "BDT": 119.5302,
    "BGN": 1.7821,
    "BHD": 0.3760,
    "BIF": 2906.5660,
    "BMD": 1.0000,
    "BND": 1.3039,
    "BOB": 6.9325,
    "BRL": 5.4997,
    "BSD": 1.0000,
    "BTN": 83.9951,
    "BWP": 13.2535,
    "BYN": 3.2696,
    "BZD": 2.0000,
    "CAD": 1.3650,
    "CDF": 2843.8912,
    "CHF": 0.8572,
    "CLP": 925.1883,
    "CNY": 7.0635,
    "COP": 4232.2537,
    "CRC": 518.8799,
    "CUP": 24.0000,
    "CVE": 100.4780,
    "CZK": 23.0704,
    "DJF": 177.7210,
    "DKK": 6.7949,
    "DOP": 60.2657,
    "DZD": 133.0801,
    "EGP": 48.4954,
    "ERN": 15.0000,
    "ETB": 118.5050,
    "EUR": 0.9113,
    "FJD": 2.2223,
    "FKP": 0.7635,
    "FOK": 6.7949,
    "GBP": 0.7635,
    "GEL": 2.7290,
    "GGP": 0.7635,
    "GHS": 15.9830,
    "GIP": 0.7635,
    "GMD": 70.7193,
    "GNF": 8675.8677,
    "GTQ": 7.7457,
    "GYD": 209.0932,
    "HKD": 7.7744,
    "HNL": 24.8877,
    "HRK": 6.8657,
    "HTG": 131.8379,
    "HUF": 364.4969,
    "IDR": 15670.6050,
    "ILS": 3.7722,
    "IMP": 0.7635,
    "INR": 83.9952,
    "IQD": 1311.9600,
    "IRR": 42056.7486,
    "ISK": 135.1942,
    "JEP": 0.7635,
    "JMD": 158.0988,
    "JOD": 0.7090,
    "JPY": 148.1755,
    "KES": 129.0685,
    "KGS": 84.4631,
    "KHR": 4075.9309,
    "KID": 1.4838,
    "KMF": 448.3012,
    "KRW": 1346.6440,
    "KWD": 0.3065,
    "KYD": 0.8333,
    "KZT": 485.8605,
    "LAK": 21970.6461,
    "LBP": 89500.0000,
    "LKR": 293.2558,
    "LRD": 193.0711,
    "LSL": 17.5574,
    "LYD": 4.7819,
    "MAD": 9.8093,
    "MDL": 17.5717,
    "MGA": 4560.7542,
    "MKD": 55.9904,
    "MMK": 2096.7475,
    "MNT": 3375.0462,
    "MOP": 8.0076,
    "MRU": 39.5137,
    "MUR": 46.3780,
    "MWK": 1744.8254,
    "MXN": 19.3460,
    "MYR": 4.2868,
    "MZN": 63.9143,
    "NAD": 17.5574,
    "NGN": 1616.5943,
    "NIO": 36.8086,
    "NOK": 10.6838,
    "NPR": 134.3921,
    "NZD": 1.6321,
    "OMR": 0.3845,
    "PAB": 1.0000,
    "PEN": 3.7257,
    "PGK": 3.9427,
    "PHP": 56.8534,
    "PKR": 277.9621,
    "PLN": 3.9250,
    "PYG": 7828.6783,
    "QAR": 3.6400,
    "RON": 4.5321,
    "RSD": 106.6384,
    "RUB": 96.4020,
    "RWF": 1356.5181,
    "SAR": 3.7500,
    "SBD": 8.4814,
    "SCR": 13.5244,
    "SDG": 449.1426,
    "SEK": 10.3408,
    "SGD": 1.3039,
    "SHP": 0.7635,
    "SLE": 22.5863,
    "SLL": 22586.3304,
    "SOS": 571.3921,
    "SRD": 31.6543,
    "SSP": 3200.0792,
    "STN": 22.3254,
    "SYP": 12877.5518,
    "SZL": 17.5574,
    "THB": 33.5089,
    "TJS": 10.6432,
    "TMT": 3.5000,
    "TND": 3.0675,
    "TOP": 2.3254,
    "TRY": 34.2743,
    "TTD": 6.7672,
    "TVD": 1.4838,
    "TWD": 32.2029,
    "TZS": 2714.5874,
    "UAH": 41.1827,
    "UGX": 3679.7234,
    "UYU": 41.4841,
    "UZS": 12770.3791,
    "VES": 37.0740,
    "VND": 24834.9725,
    "VUV": 117.9866,
    "WST": 2.6944,
    "XAF": 597.7349,
    "XCD": 2.7000,
    "XDR": 0.7460,
    "XOF": 597.7349,
    "XPF": 108.7402,
    "YER": 250.2612,
    "ZAR": 17.5579,
    "ZMW": 26.6156,
    "ZWL": 25.8683,
  };

  @override
  void initState() {
    super.initState();
    _targetCurrencies = conversionRates.keys.toList();
  }

  // Function to convert currency
  void _convertCurrency() {
    setState(() {
      _convertedAmount = _inputAmount * (conversionRates[_selectedCurrency] ?? 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text(
          "Advanced Exchanger",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
            children: [
              const SizedBox(height: 20), // Add space below the AppBar
              const Text(
                'INSERT AMOUNT:',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 4,
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _inputAmount = double.tryParse(value) ?? 0.0;
                          _convertCurrency(); // Automatically convert when the amount changes
                        });
                      },
                    ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedCurrency,
                        icon: const Icon(Icons.arrow_drop_down),
                        items: _targetCurrencies.map((String currency) {
                          return DropdownMenuItem<String>(
                            value: currency,
                            child: Text(currency),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCurrency = newValue!;
                            _convertCurrency(); 
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              if (_convertedAmount != null)
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Converted Amount: ${_convertedAmount?.toStringAsFixed(2)} $_selectedCurrency',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}