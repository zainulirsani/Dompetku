// lib/features/transactions/presentation/pages/transaction_list_page.dart
import 'package:flutter/material.dart';
import 'package:dompetku/common/constants/app_colors.dart'; // Pastikan import ini ada

enum ChartType { pie, line }
class TransactionListPage extends StatelessWidget {
  const TransactionListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // --- DATA DUMMY (SEMENTARA) ---
    // Nantinya, data ini akan kita ambil dari state management (Riverpod)
    final dummyTransactions = [
      {
        'type': 'expense',
        'category': 'Makanan',
        'title': 'Makan Siang Nasi Padang',
        'amount': 25000.0,
        'icon': Icons.fastfood_rounded,
      },
      {
        'type': 'expense',
        'category': 'Transportasi',
        'title': 'Gojek ke Kantor',
        'amount': 18000.0,
        'icon': Icons.motorcycle_rounded,
      },
      {
        'type': 'income',
        'category': 'Gaji',
        'title': 'Gaji Bulan September',
        'amount': 5000000.0,
        'icon': Icons.work_rounded,
      },
      {
        'type': 'expense',
        'category': 'Hiburan',
        'title': 'Langganan Netflix',
        'amount': 54000.0,
        'icon': Icons.movie_rounded,
      },
    ];

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('UangKu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () {
              // TODO: Fungsi untuk filter
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // --- BAGIAN 1: KARTU RINGKASAN ---
          _buildBalanceCard(theme),

          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(child: _buildIncomeExpenseCard(theme, title: 'Pemasukan', amount: 'Rp 5.000.000', color: AppColors.lightGreen)),
              const SizedBox(width: 16),
              Expanded(child: _buildIncomeExpenseCard(theme, title: 'Pengeluaran', amount: 'Rp 97.000', color: AppColors.errorRed)),
            ],
          ),

          const SizedBox(height: 24),

          // --- BAGIAN 2: GRAFIK PENGELUARAN ---
          Text('Pengeluaran per Kategori', style: theme.textTheme.titleLarge),
          const SizedBox(height: 16),
          _buildChartPlaceholder(theme),
          
          const SizedBox(height: 24),

          // --- BAGIAN 3: RIWAYAT TRANSAKSI ---
          Text('Riwayat Transaksi', style: theme.textTheme.titleLarge),
          const SizedBox(height: 16),
          ...dummyTransactions.map((tx) => _buildTransactionItem(theme, tx)),
        ],
      ),
    );
  }

  // Helper widget untuk kartu saldo utama
  Widget _buildBalanceCard(ThemeData theme) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Saldo Bulan Ini', style: theme.textTheme.titleMedium?.copyWith(color: Colors.white70)),
            const SizedBox(height: 8),
            const Text('Rp 4.903.000', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
      ),
      color: AppColors.deepGreen,
    );
  }

  // Helper widget untuk kartu pemasukan & pengeluaran
  Widget _buildIncomeExpenseCard(ThemeData theme, {required String title, required String amount, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.labelLarge?.copyWith(color: color)),
          const SizedBox(height: 4),
          Text(amount, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  // Helper widget untuk placeholder grafik
  Widget _buildChartPlaceholder(ThemeData theme) {
    return Container(
      height: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor, width: 0.5),
      ),
      child: Center(
        child: Text(
          'Grafik akan muncul di sini.\n(Gunakan package seperti fl_chart)',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
        ),
      ),
    );
  }

  // Helper widget untuk setiap item transaksi
  Widget _buildTransactionItem(ThemeData theme, Map<String, dynamic> tx) {
    final bool isExpense = tx['type'] == 'expense';
    final color = isExpense ? AppColors.errorRed : AppColors.lightGreen;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        leading: Icon(tx['icon'] as IconData, color: color, size: 28),
        title: Text(tx['title'] as String, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
        subtitle: Text(tx['category'] as String),
        trailing: Text(
          '${isExpense ? '-' : '+'}Rp ${tx['amount']}',
          style: theme.textTheme.bodyMedium?.copyWith(color: color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}