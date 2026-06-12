class Gasto {
  final String id;
  final String descricao;
  final double valor;
  final DateTime data;
  final String categoria;

  Gasto({
    String? id,
    required this.descricao,
    required this.valor,
    required this.data,
    required this.categoria,
  }) : id = id ?? DateTime.now().millisecondsSinceEpoch.toString();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'valor': valor,
      'data': data.toIso8601String(),
      'categoria': categoria,
    };
  }

  factory Gasto.fromJson(Map<String, dynamic> json) {
    return Gasto(
      id: json['id'] as String,
      descricao: json['descricao'] as String,
      valor: (json['valor'] as num).toDouble(),
      data: json['data'] != null ? DateTime.parse(json['data'] as String) : DateTime.now(),
      categoria: json['categoria'] as String? ?? 'Outros',    
    );
  }
}