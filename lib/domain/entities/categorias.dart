import 'package:flutter/material.dart';

class Categoria {
  final String nome;
  final IconData icon;
  final Color cor;

  const Categoria({
    required this.nome,
    required this.icon,
    required this.cor,
  });
}

final List<Categoria> listaCategorias = [
  const Categoria(nome: 'Alimentação', icon: Icons.fastfood, cor: Colors.orange),
  const Categoria(nome: 'Transporte', icon: Icons.directions_car, cor: Colors.blue),
  const Categoria(nome: 'Casa', icon: Icons.home, cor: Colors.green),
  const Categoria(nome: 'Lazer', icon: Icons.sports_esports, cor: Colors.purple),
  const Categoria(nome: 'Saúde', icon: Icons.favorite, cor: Colors.red),
  const Categoria(nome: 'Mercado', icon: Icons.shopping_cart, cor: Colors.teal),
];