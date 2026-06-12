import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/theme/app_theme.dart';
import 'controllers/gasto_controller.dart';
import 'data/datasources/gasto_local_datasource.dart';
import 'data/repositories/gasto_repository.dart';
import 'views/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);

  //  Injeção de dependências limpa e linear
  final dataSource = GastoLocalDataSource();
  final repository = GastoRepository(dataSource);
  final gastoController = GastoController(repository);

  runApp(MyApp(gastoController: gastoController));
}

class MyApp extends StatelessWidget {
  final GastoController gastoController;

  const MyApp({super.key, required this.gastoController});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: HomePage(controller: gastoController),
    );
  }
}