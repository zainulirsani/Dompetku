// lib/features/transactions/presentation/pages/budget_page.dart
import 'package:flutter/material.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anggaran'),
      ),
      body: const Center(
        child: Text('Halaman Anggaran (Budget)'),
      ),
    );
  }
}