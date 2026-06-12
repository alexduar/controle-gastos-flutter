import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/gasto_model.dart';

class GastoLocalDataSource {
  static const _key = 'gastos';

  Future<List<Gasto>> buscarGastos() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data == null) return [];

    final List decoded = jsonDecode(data);
    return decoded.map((e) => Gasto.fromJson(e)).toList();
  }

  Future<void> salvarGastos(List<Gasto> gastos) async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(gastos.map((e) => e.toJson()).toList());
    await prefs.setString(_key, data);
  }
}