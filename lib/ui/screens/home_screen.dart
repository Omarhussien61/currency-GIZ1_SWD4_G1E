import 'package:dropdown_search/dropdown_search.dart';
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
  String _selectedCurrency = 'EGP'; // Default selected currency
  double _inputAmount = 1.0;
  double? _convertedAmount;

  // Store the conversion rates map
  final Map<String, double> conversionRates = {
    "EGP": 1,
    "AED": 0.07562,
    "AFN": 1.3910,
    "ALL": 1.8575,
    "AMD": 7.9792,
    "ANG": 0.03686,
    "AOA": 19.1094,
    "ARS": 20.1658,
    "AUD": 0.03062,
    "AWG": 0.03686,
    "AZN": 0.03504,
    "BAM": 0.03683,
    "BBD": 0.04118,
    "BDT": 2.4597,
    "BGN": 0.03683,
    "BHD": 0.007742,
    "BIF": 59.9458,
    "BMD": 0.02059,
    "BND": 0.02693,
    "BOB": 0.1428,
    "BRL": 0.1150,
    "BSD": 0.02059,
    "BTN": 1.7292,
    "BWP": 0.2743,
    "BYN": 0.06709,
    "BZD": 0.04118,
    "CAD": 0.02830,
    "CDF": 58.8391,
    "CHF": 0.01765,
    "CLP": 19.2253,
    "CNY": 0.1458,
    "COP": 87.3161,
    "CRC": 10.6526,
    "CUP": 0.4941,
    "CVE": 2.0766,
    "CZK": 0.4772,
    "DJF": 3.6592,
    "DKK": 0.1405,
    "DOP": 1.2406,
    "DZD": 2.7436,
    "ERN": 0.3088,
    "ETB": 2.4930,
    "EUR": 0.01883,
    "FJD": 0.04585,
    "FKP": 0.01576,
    "FOK": 0.1406,
    "GBP": 0.01576,
    "GEL": 0.05611,
    "GGP": 0.01576,
    "GHS": 0.3290,
    "GIP": 0.01576,
    "GMD": 1.4570,
    "GNF": 178.4614,
    "GTQ": 0.1594,
    "GYD": 4.3126,
    "HKD": 0.1600,
    "HNL": 0.5123,
    "HRK": 0.1419,
    "HTG": 2.7160,
    "HUF": 7.5340,
    "IDR": 323.9561,
    "ILS": 0.07769,
    "IMP": 0.01576,
    "INR": 1.7286,
    "IQD": 26.9677,
    "IRR": 878.1096,
    "ISK": 2.7972,
    "JEP": 0.01576,
    "JMD": 3.2590,
    "JOD": 0.01460,
    "JPY": 3.0602,
    "KES": 2.6590,
    "KGS": 1.7469,
    "KHR": 83.9397,
    "KID": 0.03062,
    "KMF": 9.2653,
    "KRW": 27.8039,
    "KWD": 0.006314,
    "KYD": 0.01716,
    "KZT": 10.1379,
    "LAK": 453.0648,
    "LBP": 1842.7645,
    "LKR": 6.0387,
    "LRD": 3.9807,
    "LSL": 0.3611,
    "LYD": 0.09864,
    "MAD": 0.2024,
    "MDL": 0.3638,
    "MGA": 94.3772,
    "MKD": 1.1567,
    "MMK": 43.2211,
    "MNT": 69.6279,
    "MOP": 0.1648,
    "MRU": 0.8166,
    "MUR": 0.9503,
    "MVR": 0.3182,
    "MWK": 35.8877,
    "MXN": 0.4007,
    "MYR": 0.08836,
    "MZN": 1.3165,
    "NAD": 0.3611,
    "NGN": 33.3736,
    "NIO": 0.7582,
    "NOK": 0.2212,
    "NPR": 2.7668,
    "NZD": 0.03387,
    "OMR": 0.007917,
    "PAB": 0.02059,
    "PEN": 0.07679,
    "PGK": 0.08099,
    "PHP": 1.1826,
    "PKR": 5.7252,
    "PLN": 0.08099,
    "PYG": 161.0805,
    "QAR": 0.07495,
    "RON": 0.09375,
    "RSD": 2.2052,
    "RUB": 2.0022,
    "RWF": 28.4013,
    "SAR": 0.07721,
    "SBD": 0.1742,
    "SCR": 0.2817,
    "SDG": 10.5505,
    "SEK": 0.2140,
    "SGD": 0.02693,
    "SHP": 0.01576,
    "SLE": 0.4764,
    "SLL": 476.4429,
    "SOS": 11.7830,
    "SRD": 0.6657,
    "SSP": 66.1169,
    "STN": 0.4614,
    "SYP": 266.0556,
    "SZL": 0.3611,
    "THB": 0.6907,
    "TJS": 0.2200,
    "TMT": 0.07212,
    "TND": 0.06338,
    "TOP": 0.04852,
    "TRY": 0.7054,
    "TTD": 0.1398,
    "TVD": 0.03062,
    "TWD": 0.6634,
    "TZS": 56.1583,
    "UAH": 0.8491,
    "UGX": 75.7014,
    "USD": 0.02059,
    "UYU": 0.8525,
    "UZS": 263.1146,
    "VES": 0.7752,
    "VND": 511.2844,
    "VUV": 2.4550,
    "WST": 0.05583,
    "XAF": 12.3538,
    "XCD": 0.05559,
    "XDR": 0.01539,
    "XOF": 12.3538,
    "XPF": 2.2474,
    "YER": 5.1576,
    "ZAR": 0.3611,
    "ZMW": 0.5453,
    "ZWL": 0.1250
  };

  @override
  void initState() {
    super.initState();
    _targetCurrencies = conversionRates.keys.toList();
  }

  // Function to convert currency
  void _convertCurrency() {
    setState(() {
      _convertedAmount = _inputAmount / (conversionRates[_selectedCurrency] ?? 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text(
          "DEPI",
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
            children: [
              Container(height:150,child: Center(child: Image.asset("assets/pro"
                  ".png"))),
               Center(
                 child: Text(
                  'GIZ1_SWD4_G1E',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,
                      color: Colors.blue[200]),
                               ),
               ),
              const SizedBox(height: 20), // Add space below the AppBar
              const Text(
                'INSERT AMOUNT:',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                        suffix: Text("EGP")
                      ),
                      onChanged: (value) {
                        setState(() {
                          _inputAmount = double.tryParse(value) ?? 0.0;
                          _convertCurrency(); // Automatically convert when the amount changes
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              DropdownSearch<String>(
                compareFn: (item,filter) {
                  return true;
                },

                itemAsString: (u) => "${u}",
                dropdownBuilder: _customPopupItemBuilderExample2,
                selectedItem:  _selectedCurrency,
                decoratorProps: DropDownDecoratorProps(

                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                    filled: true,
                    fillColor: Colors.blue,
                    suffixIconColor: Colors.white,
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 0.1), borderRadius: BorderRadius.circular(10), gapPadding: 0),
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 0.1), borderRadius: BorderRadius.circular(10), gapPadding: 0),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 0.1), borderRadius: BorderRadius.circular(10), gapPadding: 0),
                    iconColor: Colors.white,
                  ),

                ),

                items:(filter, infiniteScrollProps) =>
                    _targetCurrencies,
                onChanged: (item) {
                  setState(() {
                    _selectedCurrency = item!;
                    _convertCurrency();
                  });                },
                popupProps: PopupProps.menu(
                  showSearchBox: true,
                  searchFieldProps: TextFieldProps(
                    decoration: InputDecoration(
                      hintText: 'Search for a Currency',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

              ),
              const SizedBox(height: 16),
              if (_convertedAmount != null)
                Card(
                  elevation: 4,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(vertical:16,
                          horizontal: 10),
                      child: Center(
                        child: Text(
                          'Converted Amount\n ${_convertedAmount?.toStringAsFixed(2)}\n $_selectedCurrency',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _customPopupItemBuilderExample2(BuildContext? context, item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.money,
          color: Colors.white,
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          child: Text(
            "${item}",
            style: TextStyle(
                fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

}