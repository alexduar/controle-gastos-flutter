import 'package:flutter/material.dart';
import '../controllers/gasto_controller.dart';
import '../data/categorias.dart';
import 'package:intl/intl.dart';

class RankingPage extends StatelessWidget {
  final GastoController controller;

  RankingPage({super.key, required this.controller});

  final formatador =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  Widget build(BuildContext context) {
    final ranking = controller.rankingPorCategoria();

    final ordenado = ranking.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF121212),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "🏆 Ranking de categorias",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          if (ordenado.isEmpty)
            const Text(
              "Nenhum gasto ainda",
              style: TextStyle(color: Colors.white70),
            ),

          ...ordenado.map((e) {
            final categoria = categorias.firstWhere(
              (c) => c.nome == e.key,
              orElse: () => categorias.first,
            );

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: categoria.cor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(categoria.icon, color: categoria.cor),
                      const SizedBox(width: 10),
                      Text(
                        e.key,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Text(
                    formatador.format(e.value),
                    style: TextStyle(
                      color: categoria.cor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}