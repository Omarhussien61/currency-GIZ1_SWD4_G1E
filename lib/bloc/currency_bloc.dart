import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/currency_repository.dart';
import 'currency_event.dart';
import 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final CurrencyRepository repository;

  CurrencyBloc({required this.repository}) : super(CurrencyInitial()) {
    on<FetchRates>((event, emit) async {
      emit(CurrencyLoading());
      try {
        final rates = await repository.getRates(event.baseCurrency);
        emit(CurrencyLoaded(rates: rates.rates, targetCurrencies: []));
      } catch (e) {
        emit(CurrencyError(message: e.toString()));
      }
    });

    on<AddTargetCurrency>((event, emit) {
      if (state is CurrencyLoaded) {
        final currentState = state as CurrencyLoaded;
        emit(CurrencyLoaded(
            rates: currentState.rates,
            targetCurrencies: [...currentState.targetCurrencies, event.currency]));
      }
    });

    on<RemoveTargetCurrency>((event, emit) {
      if (state is CurrencyLoaded) {
        final currentState = state as CurrencyLoaded;
        emit(CurrencyLoaded(
            rates: currentState.rates,
            targetCurrencies: currentState.targetCurrencies
                .where((currency) => currency != event.currency)
                .toList()));
      }
    });
  }
}
