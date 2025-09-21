// lib/data/models/transaction.dart

// Enum untuk membedakan tipe transaksi
enum TransactionType {
  income,
  expense,
}

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final String? category; // Kategori bisa opsional

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    this.category,
  });
}