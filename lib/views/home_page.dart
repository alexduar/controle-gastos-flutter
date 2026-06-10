import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../controllers/gasto_controller.dart';
import '../models/gasto_model.dart';
import '../widgets/gasto_card.dart';
import '../data/categorias.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = GastoController();

  final produtoController = TextEditingController();
  final valorController = TextEditingController();

  final formatador =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  int mesSelecionado = DateTime.now().month;
  int anoSelecionado = DateTime.now().year;

  String categoriaSelecionada = 'Alimentação';

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    await controller.carregar();
    setState(() {});
  }

  double _parseCurrency(String text) {
    String digits = text.replaceAll(RegExp(r'[^0-9]'), '');
    return digits.isEmpty ? 0.0 : double.parse(digits) / 100;
  }

  void adicionarGasto() async {
    if (produtoController.text.isEmpty ||
        valorController.text.isEmpty) return;

    double valor = _parseCurrency(valorController.text);

    if (valor <= 0) return;

    await controller.adicionar(
      Gasto(
        descricao: produtoController.text,
        valor: valor,
        data: DateTime.now(),
        categoria: categoriaSelecionada, // ✅ AGORA SALVA CATEGORIA
      ),
    );

    setState(() {
      produtoController.clear();
      valorController.clear();
    });
  }

  String nomeMes(int mes) {
    return DateFormat.MMMM('pt_BR')
        .format(DateTime(0, mes));
  }

  @override
  Widget build(BuildContext context) {
    final gastosFiltrados = controller.filtrarPorMes(
      anoSelecionado,
      mesSelecionado,
    );

    final totalMes =
        controller.totalPorMes(anoSelecionado, mesSelecionado);

    final totalAno =
        controller.totalPorAno(anoSelecionado);

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),

      appBar: AppBar(
        title: const Text(
          'Meus Gastos',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF0F0F0F),
        elevation: 0,
      ),

      body: Column(
        children: [
          const SizedBox(height: 10),

          // 🔥 CARDS RESUMO
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildCard("Mês", formatador.format(totalMes), Colors.green),
                const SizedBox(width: 10),
                _buildCard("Ano", formatador.format(totalAno), Colors.blue),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // 🔥 SELETOR DE MÊS
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1C),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (mesSelecionado == 1) {
                        mesSelecionado = 12;
                        anoSelecionado--;
                      } else {
                        mesSelecionado--;
                      }
                    });
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                ),

                Text(
                  "${nomeMes(mesSelecionado)} $anoSelecionado",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    setState(() {
                      if (mesSelecionado == 12) {
                        mesSelecionado = 1;
                        anoSelecionado++;
                      } else {
                        mesSelecionado++;
                      }
                    });
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                  color: Colors.white,
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // 🔥 CATEGORIAS (NOVO)
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categorias.length,
              itemBuilder: (context, index) {
                final cat = categorias[index];

                final isSelected =
                    cat.nome == categoriaSelecionada;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      categoriaSelecionada = cat.nome;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? cat.cor.withOpacity(0.3)
                          : const Color(0xFF1C1C1C),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? cat.cor
                            : Colors.transparent,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(cat.icon, color: cat.cor),
                        const SizedBox(height: 5),
                        Text(
                          cat.nome,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // 🔥 INPUTS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                TextField(
                  controller: produtoController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Produto',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFF1C1C1C),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                TextField(
                  controller: valorController,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Valor',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFF1C1C1C),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    double number = _parseCurrency(value);
                    String formatted = formatador.format(number);

                    valorController.value = TextEditingValue(
                      text: formatted,
                      selection: TextSelection.collapsed(
                        offset: formatted.length,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 🔥 LISTA
          Expanded(
            child: gastosFiltrados.isEmpty
                ? const Center(
                    child: Text(
                      "Nenhum gasto neste mês",
                      style: TextStyle(color: Colors.white70),
                    ),
                  )
                : ListView.builder(
                    itemCount: gastosFiltrados.length,
                    itemBuilder: (context, index) {
                      final gasto = gastosFiltrados[index];

                      return GastoCard(
                        gasto: gasto,
                        onDelete: () async {
                          await controller.removerGasto(gasto);
                          setState(() {});
                        },
                      );
                    },
                  ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: adicionarGasto,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1C),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Column(
          children: [
            Text(title, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}