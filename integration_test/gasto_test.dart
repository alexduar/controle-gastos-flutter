import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:suvina/main.dart';
import 'package:suvina/controllers/gasto_controller.dart';
import 'package:suvina/data/datasources/gasto_local_datasource.dart';
import 'package:suvina/data/repositories/gasto_repository.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Adicionar gasto', (tester) async {

    await initializeDateFormatting('pt_BR', null);

    final dataSource = GastoLocalDataSource();
    final repository = GastoRepository(dataSource);
    final gastoController = GastoController(repository);

    await tester.pumpWidget(
      MyApp(gastoController: gastoController),
    );

    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('produto')), 'Teste');
    await tester.enterText(find.byKey(const Key('valor')), '10');

    await tester.tap(find.byKey(const Key('adicionargasto')));
    await tester.pumpAndSettle();

    expect(find.text('Teste'), findsOneWidget);
  });
}