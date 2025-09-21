// lib/features/transactions/presentation/pages/add_transaction_page.dart
import 'package:flutter/services.dart';
import 'package:dompetku/data/models/transaction.dart'; // Pastikan path import ini benar
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dompetku/common/constants/app_colors.dart';
class AddTransactionPage extends StatefulWidget {
  // Kita akan menerima tipe transaksi (Pemasukan/Pengeluaran) dari halaman sebelumnya
  final TransactionType initialTransactionType;

  const AddTransactionPage({
    super.key,
    required this.initialTransactionType,
  });

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  // State untuk mengelola pilihan di halaman ini
  late TransactionType _selectedTransactionType;
  DateTime _selectedDate = DateTime.now();

  // Controller untuk setiap text field
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedTransactionType = widget.initialTransactionType;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Method untuk menampilkan date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isExpense = _selectedTransactionType == TransactionType.expense;

    return Scaffold(
      appBar: AppBar(
        title: Text(isExpense ? 'Catat Pengeluaran' : 'Catat Pemasukan'),
        backgroundColor: Colors.transparent, // Buat AppBar transparan
        elevation: 0,
        foregroundColor: theme.colorScheme.onSurface, // Sesuaikan warna ikon & teks AppBar
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(
              onPressed: () {
                // TODO: Logika untuk menyimpan data
              },
              child: const Text('Simpan'),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // --- Switcher Pemasukan/Pengeluaran ---
          SegmentedButton<TransactionType>(
            segments: const [
              ButtonSegment(
                value: TransactionType.expense,
                label: Text('Pengeluaran'),
                icon: Icon(Icons.arrow_downward),
              ),
              ButtonSegment(
                value: TransactionType.income,
                label: Text('Pemasukan'),
                icon: Icon(Icons.arrow_upward),
              ),
            ],
            selected: {_selectedTransactionType},
            onSelectionChanged: (newSelection) {
              setState(() {
                _selectedTransactionType = newSelection.first;
              });
            },
            style: SegmentedButton.styleFrom(
              foregroundColor: theme.colorScheme.onSurface.withOpacity(0.8),
              selectedForegroundColor: theme.colorScheme.onPrimary,
              selectedBackgroundColor: isExpense ? theme.colorScheme.error : AppColors.lightGreen,
            ),
          ),

          const SizedBox(height: 24),

          // --- KARTU INPUT UTAMA (JUMLAH & DESKRIPSI) ---
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jumlah',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                TextFormField(
                  controller: _amountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly 
                  ],
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    prefixText: 'Rp ',
                    prefixStyle: TextStyle(
                      fontSize: 24, // Perkecil prefix agar fokus ke angka
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                    hintText: '0',
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Tulis deskripsi di sini...',
                    border: InputBorder.none,
                    icon: Icon(Icons.edit_note_rounded),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),

          // --- KARTU DETAIL TRANSAKSI (TANGGAL, AKUN, KATEGORI) ---
          Card(
            elevation: 0, // Gunakan shadow dari container di atas
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              side: BorderSide(color: theme.dividerColor, width: 0.5),
            ),
            clipBehavior: Clip.antiAlias, // Agar ListTile tidak keluar dari border
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.calendar_today_rounded),
                  title: const Text('Tanggal'),
                  trailing: Text(DateFormat('d MMM yyyy').format(_selectedDate)),
                  onTap: () => _selectDate(context),
                ),
                ListTile(
                  leading: const Icon(Icons.account_balance_wallet_rounded),
                  title: const Text('Akun'),
                  trailing: const Text('Dompet >'), // Placeholder
                  onTap: () {
                    // TODO: Buka halaman pilihan akun (UangKu/AssetKu)
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.label_rounded),
                  title: const Text('Kategori'),
                  trailing: const Text('Pilih >'), // Placeholder
                  onTap: () {
                    // TODO: Buka halaman pilihan kategori
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}