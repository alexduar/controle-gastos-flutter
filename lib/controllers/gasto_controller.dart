import 'package:flutter/foundation.dart';
import '../data/models/gasto_model.dart';
import '../data/repositories/gasto_repository.dart';

class GastoController extends ChangeNotifier {
  final GastoRepository _repository;
  final List<Gasto> _gastos = [];

  GastoController(this._repository);

  List<Gasto> get gastos => List.unmodifiable(_gastos);

  double get total => _gastos.fold(0.0, (soma, g) => soma + g.valor);

  Future<void> carregar() async {
    _gastos.clear();
    final dados = await _repository.carregar();
    _gastos.addAll(dados);
    notifyListeners();
  }

  Future<void> adicionar(Gasto gasto) async {
    _gastos.add(gasto);
    await _repository.salvar(_gastos);
    notifyListeners();
  }

  Future<void> removerGasto(Gasto gasto) async {
    _gastos.remove(gasto);
    await _repository.salvar(_gastos);
    notifyListeners();
  }

  List<Gasto> filtrarPorMes(int ano, int mes) {
    return _gastos.where((g) => g.data.year == ano && g.data.month == mes).toList();
  }

  double totalPorMes(int ano, int mes) {
    return filtrarPorMes(ano, mes).fold(0.0, (soma, g) => soma + g.valor);
  }
  
  double totalPorAno(int ano) {
    return _gastos.where((g) => g.data.year == ano).fold(0.0, (soma, g) => soma + g.valor);
  }

  Map<String, double> rankingPorCategoria() {
    final Map<String, double> ranking = {};
    for (var gasto in _gastos) {
      final categoria = gasto.categoria;
      ranking[categoria] = (ranking[categoria] ?? 0.0) + gasto.valor;
    }
    return ranking;
  }
}

