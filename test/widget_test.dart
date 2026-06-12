/* import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:suvina/views/home/home_page.dart';

void main() {
  testWidgets('Deve remover um gasto ao segurar', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomePage(),
      ),
    );

    // adiciona item
    await tester.enterText(find.byType(TextField).at(0), 'Arroz');
    await tester.enterText(find.byType(TextField).at(1), '10');
    await tester.tap(find.byIcon(Icons.attach_money));
    await tester.pumpAndSettle();

    // garante que apareceu corretamente
    expect(find.textContaining('Produto: Arroz'), findsOneWidget);

    // faz o long press no item completo (mais seguro)
    await tester.longPress(find.textContaining('Produto: Arroz'));
    await tester.pumpAndSettle();

    // verifica que foi removido
    expect(find.textContaining('Produto: Arroz'), findsNothing);
  });
} */