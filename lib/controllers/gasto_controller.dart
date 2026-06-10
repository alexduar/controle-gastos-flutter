import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/gasto_model.dart';

class GastoController {
  final List<Gasto> _gastos = [];

  List<Gasto> get gastos => _gastos;

  Future<void> carregar() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('gastos');

    _gastos.clear();

    if (data == null) return;

    final List decoded = jsonDecode(data);

    _gastos.addAll(
      decoded.map((e) => Gasto.fromJson(e)).toList(),
    );
  }

  Future<void> salvar() async {
    final prefs = await SharedPreferences.getInstance();

    final data = jsonEncode(
      _gastos.map((e) => e.toJson()).toList(),
    );

    await prefs.setString('gastos', data);
  }

  Future<void> adicionar(Gasto gasto) async {
    _gastos.add(gasto);
    await salvar();
  }

  Future<void> removerGasto(Gasto gasto) async {
    _gastos.remove(gasto);
    await salvar();
  }

  double get total =>
      _gastos.fold(0.0, (soma, g) => soma + g.valor);

  List<Gasto> filtrarPorMes(int ano, int mes) {
    return _gastos.where((gasto) {
      return gasto.data.year == ano &&
             gasto.data.month == mes;
    }).toList();
  }

  double totalPorMes(int ano, int mes) {
    return filtrarPorMes(ano, mes)
        .fold(0.0, (soma, g) => soma + g.valor);
  }
  
  double totalPorAno(int ano) {
  return _gastos
      .where((g) => g.data.year == ano)
      .fold(0.0, (soma, g) => soma + g.valor);
}
}