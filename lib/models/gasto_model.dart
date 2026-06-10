class Gasto {
  final String produto;
  final double valor;
  final DateTime data;

  Gasto({
    required this.produto,
    required this.valor,
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      'produto': produto,
      'valor': valor,
      'data': data.toIso8601String(), // ✅ correto
    };
  }

  factory Gasto.fromJson(Map<String, dynamic> json) {
    return Gasto(
      produto: json['produto'],
      valor: json['valor'],
      data: json['data'] != null
          ? DateTime.parse(json['data'])
          : DateTime.now(), // evita crash com dados antigos
    );
  }
}