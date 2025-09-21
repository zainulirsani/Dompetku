// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dompetku/main_page.dart';
import 'package:dompetku/common/constants/app_colors.dart'; // <-- 1. Import file warna Anda

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DompetKu',
      debugShowCheckedModeBanner: false,
      
      // --- 2. Terapkan Tema Baru ---
      theme: ThemeData(
        useMaterial3: true,
        // Definisikan ColorScheme utama aplikasi
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.deepGreen,
          primary: AppColors.deepGreen,
          secondary: AppColors.lightGreen,
          error: AppColors.errorRed,
          background: AppColors.backgroundLight,
          surface: AppColors.surfaceWhite,
        ),
        
        // Definisikan warna-warna spesifik untuk komponen
        scaffoldBackgroundColor: AppColors.backgroundLight,
        
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.deepGreen,
          foregroundColor: Colors.white, // Warna untuk title dan icons di AppBar
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.goldAccent,
          foregroundColor: AppColors.textDark,
        ),

        // Definisikan style teks
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: AppColors.textDark),
          bodySmall: TextStyle(color: AppColors.textGrey),
        ),
      ),
      
      home: const MainPage(),
    );
  }
}