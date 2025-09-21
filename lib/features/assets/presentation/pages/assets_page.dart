// lib/features/assets/presentation/pages/assets_page.dart
import 'package:flutter/material.dart';

class AssetsPage extends StatelessWidget {
  const AssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asetku'),
      ),
      body: const Center(
        child: Text('Halaman untuk menampilkan aset investasi.'),
      ),
    );
  }
}