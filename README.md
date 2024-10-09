# Currency Exchange App

This Flutter application displays real-time currency exchange rates and allows users to manage their preferred currencies. The app uses the BLoC architecture for state management and interacts with a currency API to fetch exchange rates.

## Table of Contents

1. [Features](#features)
2. [Prerequisites](#prerequisites)
3. [Installation](#installation)
4. [Project Structure](#project-structure)
5. [How to Use](#how-to-use)
6. [State Management (BLoC)](#state-management-bloc)
7. [API Integration](#api-integration)
8. [Example Usage](#example-usage)
9. [Running Tests](#running-tests)
10. [Contribution Guidelines](#contribution-guidelines)
11. [Contact](#contact)
12. [License](#license)

---

## Features

- **Fetch Exchange Rates**: Retrieve real-time exchange rates for multiple currencies.
- **Preferred Currencies**: Add or remove preferred currencies for quick access.
- **BLoC State Management**: The app follows the BLoC pattern for efficient state management.
- **Persistent Storage**: Save preferred currencies locally (using shared preferences).

---

## Prerequisites

Before you can run the project, ensure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (Ensure Flutter is set up and the correct environment variables are configured).
- A currency API service (e.g., [exchangeratesapi.io](https://exchangeratesapi.io/) or [Fixer.io](https://fixer.io/)) for fetching exchange rates.
  
---

## Installation

1. **Clone the repository**:

    ```bash
    git clone https://github.com/yourusername/currency-exchange-app.git
    cd currency-exchange-app
    ```

2. **Install dependencies**:

    Run the following command to get all required dependencies for the Flutter project:

    ```bash
    flutter pub get
    ```

3. **Run the app**:

    Once the dependencies are installed, run the app using:

    ```bash
    flutter run
    ```

4. **Configure API Service**:

    Set up your API key in `currency_service.dart`. For example:

    ```dart
    class CurrencyService {
      final String apiUrl = 'https://api.exchangeratesapi.io/latest?base=';

      Future<Map<String, double>> fetchExchangeRates(String baseCurrency) async {
        final response = await http.get('$apiUrl$baseCurrency&apiKey=YOUR_API_KEY');
      }
    }
    ```

    Replace `YOUR_API_KEY` with the actual API key from your currency exchange API service.

---

## Project Structure

Here's an overview of the project's structure:

```
lib/
│
├── blocs/                    # BLoC classes for state management
│   └── currency_bloc.dart     # Main BLoC handling currency-related events and state changes
│
├── models/                   # Models for data structure
│   └── currency.dart          # Currency model for exchange rates
│
├── services/                 # Services to handle API calls
│   └── currency_service.dart  # Service to fetch exchange rates from API
│
├── views/                    # UI elements and screens
│   └── home_screen.dart       # Main screen of the app
│
└── main.dart                 # Entry point of the application
```

---

## How to Use

1. **Fetching Exchange Rates**:
   - Upon launching the app, users can input a base currency to fetch the latest exchange rates.
   
2. **Manage Preferred Currencies**:
   - Users can add currencies to their preferred list. This list is saved and remains accessible even after the app is closed.
   - Users can remove currencies from the preferred list.

---

## State Management (BLoC)

This project uses BLoC (Business Logic Component) to manage the state of the application, such as:

- **Currency Events**: These are actions that trigger state changes, like `FetchCurrencies`, `AddPreferredCurrency`, and `RemovePreferredCurrency`.
- **Currency State**: Holds the app's current data, including the exchange rates and preferred currencies.

```dart
class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyService currencyService;

  CurrencyBloc(this.currencyService) : super(CurrencyState());

  @override
  Stream<CurrencyState> mapEventToState(CurrencyEvent event) async* {
    if (event is FetchCurrencies) {
      try {
        final rates = await currencyService.fetchExchangeRates(event.inputCurrency);
        yield CurrencyState(exchangeRates: rates, preferredCurrencies: state.preferredCurrencies);
      } catch (e) {
        // Handle error
      }
    } else if (event is AddPreferredCurrency) {
      final updatedPreferredCurrencies = List.from(state.preferredCurrencies)..add(event.currencyCode);
      yield CurrencyState(exchangeRates: state.exchangeRates, preferredCurrencies: updatedPreferredCurrencies);
    } else if (event is RemovePreferredCurrency) {
      final updatedPreferredCurrencies = List.from(state.preferredCurrencies)..remove(event.currencyCode);
      yield CurrencyState(exchangeRates: state.exchangeRates, preferredCurrencies: updatedPreferredCurrencies);
    }
  }
}
```

---

## API Integration

The app fetches live exchange rates from a currency API using the `CurrencyService`. You can use services like [exchangeratesapi.io](https://exchangeratesapi.io/) or [Fixer.io](https://fixer.io/).

Ensure you configure the API key in `currency_service.dart` as mentioned above.

---

## Example Usage

Here is an example showing how the `CurrencyBloc` handles events and states:

```dart
class FetchCurrencies extends CurrencyEvent {
  final String inputCurrency;
  FetchCurrencies(this.inputCurrency);
}

class CurrencyState {
  final Map<String, double> exchangeRates;
  final List<String> preferredCurrencies;

  CurrencyState({this.exchangeRates = const {}, this.preferredCurrencies = const []});
}
```

---

## Running Tests

To ensure everything works as expected, run the tests using:

```bash
flutter test
```

---

## Contribution Guidelines

To contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add some feature'`).
5. Push the branch (`git push origin feature-branch`).
6. Open a pull request.

---

## Contact

If you have any questions or need further assistance, feel free to reach out to:

- **Rishan**: [mohamedrishan224@gmai.com]
- GitHub: [https://github.com/yourusername]

---

## License

This project is licensed under the Rishan  - see the [LICENSE](LICENSE) file for details.


