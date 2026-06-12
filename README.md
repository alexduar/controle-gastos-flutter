
# 💸 Controle de Gastos (Flutter)

---

# Repositorio
https://github.com/alexduar/controle-gastos-flutter

---

Aplicativo simples desenvolvido em Flutter para controle de gastos do dia a dia.  
Permite adicionar produtos com seus respectivos valores, listar os itens e visualizar o total gasto.

---

lib/
├── core/
│   └── theme/
│       └─ app_theme.dart          # Centraliza a estilização do MaterialApp
├── data/
│   ├── datasources/
│   │   └─ gasto_local_datasource.dart # Contrato e implementação do SharedPreferences
│   ├── models/
│   │   └─ gasto_model.dart        # O modelo com as conversões JSON
│   └── repositories/
│       └─ gasto_repository.dart   # Ponte entre a fonte de dados e a regra de negócio
├── domain/
│   └── entities/
│       └─ categoria.dart          # Entidade pura de categorias (antigo data/categorias.dart)
├── controllers/
│   └─ gasto_controller.dart       # Gerencia o estado e regras de negócio puras
└── views/
    ├── home/
    │   ├── home_page.dart
    │   └── widgets/
    │       ├── gasto_card.dart
    │       └── resumo_card.dart   # Extraído para limpar a HomePage
    └── ranking/
        └─ ranking_page.dart

---

## 🚀 Funcionalidades

- ✅ Adicionar produto e valor
- ✅ Lista de gastos
- ✅ Remover item com pressionamento longo
- ✅ Soma automática do total gasto
- ✅ Formatação de valores em Real (R$)
- ✅ Campo de valor com máscara automática (R$ 0,00)
- ✅ Teclado numérico para entrada de valores

---

## 📱 Preview

O app possui uma interface simples contendo:
- Campo para nome do produto
- Campo para valor
- Lista de itens adicionados
- Total gasto exibido na tela

---

## 🛠️ Tecnologias utilizadas

- Flutter
- Dart
- intl (formatação de moeda)

---

## 📦 Dependências

Adicione no `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  intl: ^0.18.0