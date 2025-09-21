// lib/features/transactions/presentation/pages/transaction_list_page.dart
import 'package:flutter/material.dart';

class TransactionListPage extends StatelessWidget {
  const TransactionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
      ),
      body: const Center(
        child: Text('Daftar transaksi akan muncul di sini.'),
      ),
    );
  }
}