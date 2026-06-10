import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/gasto_controller.dart';
import '../models/gasto_model.dart';
import '../widgets/gasto_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = GastoController();

  final produtoController = TextEditingController();
  final valorController = TextEditingController();

  final formatador = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

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

  void adicionarGasto() {
    if (produtoController.text.isEmpty || valorController.text.isEmpty) return;

    double valor = _parseCurrency(valorController.text);

    if (valor <= 0) return;

    setState(() {
      controller.adicionar(
        Gasto(
          produto: produtoController.text,
          valor: valor,
          data: DateTime.now(), // ✅ ADICIONADO AQUI
        ),
      );

      produtoController.clear();
      valorController.clear();
    });
  }

  @override
  void dispose() {
    produtoController.dispose();
    valorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Controle de gastos')),
      body: Column(
        children: [
          // PRODUTO
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: produtoController,
              decoration: const InputDecoration(
                hintText: 'Produto',
                border: OutlineInputBorder(),
              ),
            ),
          ),

          // VALOR
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: valorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'R\$ 0,00',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                double number = _parseCurrency(value);
                String formatted = formatador.format(number);

                valorController.value = TextEditingValue(
                  text: formatted,
                  selection:
                      TextSelection.collapsed(offset: formatted.length),
                );
              },
            ),
          ),

          // LISTA
          Expanded(
            child: ListView.builder(
              itemCount: controller.gastos.length,
              itemBuilder: (context, index) {
                final gasto = controller.gastos[index];

                return GastoCard(
                  gasto: gasto,
                  onDelete: () {
                    setState(() {
                      controller.remover(index);
                    });
                  },
                );
              },
            ),
          ),

          // TOTAL
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              'Total: ${formatador.format(controller.total)}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: adicionarGasto,
        child: const Icon(Icons.attach_money),
      ),
    );
  }
}