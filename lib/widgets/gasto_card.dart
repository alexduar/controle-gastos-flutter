import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/gasto_model.dart';

class GastoCard extends StatelessWidget {
  final Gasto gasto;
  final VoidCallback onDelete;

  const GastoCard({
    super.key,
    required this.gasto,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final formatador =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

    final formatadorDataHora =
        DateFormat('dd/MM/yyyy HH:mm'); // ✅ data + hora

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: ListTile(
        title: Text('Produto: ${gasto.produto}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Valor: ${formatador.format(gasto.valor)}'),
            Text(
              'Data: ${formatadorDataHora.format(gasto.data)}',
            ),
          ],
        ),
        onLongPress: onDelete,
      ),
    );
  }
}