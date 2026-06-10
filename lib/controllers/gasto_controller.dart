import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/gasto_model.dart';

class GastoController {
  final List<Gasto> _gastos = [];

  List<Gasto> get gastos => _gastos;

  // 🔹 CARREGAR dados
  Future<void> carregar() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('gastos');

    if (data != null) {
      List decoded = jsonDecode(data);
      _gastos.clear();
      _gastos.addAll(
        decoded.map((e) => Gasto.fromJson(e)).toList(),
      );
    }
  }

  // 🔹 SALVAR dados
  Future<void> salvar() async {
    final prefs = await SharedPreferences.getInstance();

    final data = jsonEncode(
      _gastos.map((e) => e.toJson()).toList(),
    );

    await prefs.setString('gastos', data);
  }

  void adicionar(Gasto gasto) {
    _gastos.add(gasto);
    salvar(); // salva automaticamente
  }

  void remover(int index) {
    _gastos.removeAt(index);
    salvar(); // salva automaticamente
  }

  double get total {
    return _gastos.fold(0.0, (soma, g) => soma + g.valor);
  }
}