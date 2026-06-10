class Gasto {
  final String id;
  final String descricao;
  final double valor;
  final DateTime data;

  Gasto({
    String? id,
    required this.descricao,
    required this.valor,
    required this.data,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  /// 🔹 Converte para JSON (salvar no banco/local storage)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'valor': valor,
      'data': data.toIso8601String(),
    };
  }

  /// 🔹 Converte do JSON (ler do banco/local storage)
  factory Gasto.fromJson(Map<String, dynamic> json) {
    return Gasto(
      id: json['id'],
      descricao: json['descricao'],
      valor: (json['valor'] as num).toDouble(),
      data: json['data'] != null
          ? DateTime.parse(json['data'])
          : DateTime.now(),
    );
  }
}