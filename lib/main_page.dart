// lib/main_page.dart

import 'package:flutter/material.dart';
import 'package:dompetku/common/constants/app_colors.dart';
import 'package:dompetku/features/assets/presentation/pages/assets_page.dart';
import 'package:dompetku/features/transactions/presentation/pages/add_transaction_page.dart';
import 'package:dompetku/features/transactions/presentation/pages/dashboard_page.dart';
import 'package:dompetku/features/transactions/presentation/pages/settings_page.dart';
import 'package:dompetku/features/transactions/presentation/pages/transaction_list_page.dart';
import 'package:dompetku/data/models/transaction.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    DashboardPage(),
    TransactionListPage(),
    AssetsPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Method untuk menampilkan pilihan "Pemasukan" atau "Pengeluaran"
  void _showAddTransactionOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pilih Jenis Transaksi',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.add_circle, color: AppColors.lightGreen),
                title: const Text('Tambah Pemasukan'),
                onTap: () {
                  Navigator.pop(context); // Tutup menu pilihan
                  // Buka halaman input dengan mode "Pemasukan"
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddTransactionPage(
                        initialTransactionType: TransactionType.income,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.remove_circle, color: AppColors.errorRed),
                title: const Text('Tambah Pengeluaran'),
                onTap: () {
                  Navigator.pop(context); // Tutup menu pilihan
                  // Buka halaman input dengan mode "Pengeluaran"
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddTransactionPage(
                        initialTransactionType: TransactionType.expense,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
  
  // Widget custom untuk membuat setiap item di navigasi bawah
  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    final color = isSelected ? AppColors.deepGreen : Colors.grey;

    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(index),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 4),
              Text(label, style: TextStyle(color: color, fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      floatingActionButton: FloatingActionButton(
        // Saat ditekan, panggil method untuk menampilkan pilihan
        onPressed: () => _showAddTransactionOptions(context),
        shape: const CircleBorder(),
        child: const Icon(Icons.swap_horiz),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          children: <Widget>[
            _buildNavItem(Icons.dashboard_rounded, 'Dashboard', 0),
            _buildNavItem(Icons.account_balance_wallet_rounded, 'UangKu', 1),
            const SizedBox(width: 56),
            _buildNavItem(Icons.trending_up_rounded, 'AssetKu', 2),
            _buildNavItem(Icons.settings_rounded, 'Settings', 3),
          ],
        ),
      ),
    );
  }
}