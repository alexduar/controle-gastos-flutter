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

    final formatadorData =
        DateFormat('dd/MM/yyyy HH:mm');

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        title: Text(
          gasto.descricao, // ✅ CORRIGIDO AQUI
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Valor: ${formatador.format(gasto.valor)}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            Text(
              'Data: ${formatadorData.format(gasto.data)}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),

        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete, // mais seguro que long press
        ),
      ),
    );
  }
}