// lib/main_page.dart
import 'package:flutter/material.dart';
import 'features/transactions/presentation/pages/dashboard_page.dart';
import 'features/transactions/presentation/pages/settings_page.dart';
import 'features/transactions/presentation/pages/transaction_list_page.dart';
import 'features/transactions/presentation/pages/budget_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Indeks halaman yang sedang aktif
  int _selectedIndex = 0;

  // Daftar semua halaman yang akan ditampilkan di body
  static const List<Widget> _pages = <Widget>[
    DashboardPage(),
    TransactionListPage(),
    BudgetPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body akan menampilkan halaman sesuai dengan indeks yang dipilih
      body: _pages.elementAt(_selectedIndex),
      
      // Tombol Aksi Utama (Floating Action Button) untuk menambah transaksi
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implementasi logika tambah transaksi
        },
        child: const Icon(Icons.add),
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      
      // Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(), // Memberi coakan untuk FAB
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.dashboard,
                color: _selectedIndex == 0 ? Theme.of(context).primaryColor : Colors.grey,
              ),
              onPressed: () => _onItemTapped(0),
            ),
            IconButton(
              icon: Icon(
                Icons.list_alt,
                color: _selectedIndex == 1 ? Theme.of(context).primaryColor : Colors.grey,
              ),
              onPressed: () => _onItemTapped(1),
            ),
            const SizedBox(width: 40), // Ruang kosong untuk coakan FAB
            IconButton(
              icon: Icon(
                // Placeholder untuk menu masa depan, misal Anggaran
                Icons.pie_chart, 
                color: _selectedIndex == 2 ? Theme.of(context).primaryColor : Colors.grey,
              ),
              onPressed: () => _onItemTapped(2),
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                color: _selectedIndex == 3 ? Theme.of(context).primaryColor : Colors.grey,
              ),
              onPressed: () => _onItemTapped(3),
            ),
          ],
        ),
      ),
    );
  }
}