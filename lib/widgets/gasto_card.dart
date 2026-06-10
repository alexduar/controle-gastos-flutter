import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/gasto_model.dart';
import '../data/categorias.dart';

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

    // 🔥 pega categoria do gasto
    final categoria = categorias.firstWhere(
      (c) => c.nome == gasto.categoria,
      orElse: () => categorias.first,
    );

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),

        // 🔥 ÍCONE DA CATEGORIA
        leading: CircleAvatar(
          backgroundColor: categoria.cor.withOpacity(0.2),
          child: Icon(
            categoria.icon,
            color: categoria.cor,
          ),
        ),

        // 🔥 TITULO
        title: Text(
          gasto.descricao,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        // 🔥 SUBTITULO
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),

            Text(
              'Categoria: ${gasto.categoria}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              'Valor: ${formatador.format(gasto.valor)}',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              'Data: ${formatadorData.format(gasto.data)}',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        // 🔥 DELETE
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}