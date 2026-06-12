import '../datasources/gasto_local_datasource.dart';
import '../models/gasto_model.dart';

class GastoRepository {
  final GastoLocalDataSource _dataSource;

  GastoRepository(this._dataSource);

  Future<List<Gasto>> carregar() async {
    return await _dataSource.buscarGastos();
  }

  Future<void> salvar(List<Gasto> gastos) async {
    await _dataSource.salvarGastos(gastos);
  }
}