import 'package:flutter/material.dart';
import 'screens/main_layout_screen.dart'; // ✅ GANTI KE MAIN LAYOUT
import 'screens/daftar_layanan_screen.dart';
import 'screens/daftar_pesanan_screen.dart';
import 'screens/kategori_layanan_screen.dart';
import 'utils/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Manajemen Reservasi',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainLayoutScreen(), // ✅ LANGSUNG KE MAIN LAYOUT
      routes: {
        '/main': (context) => const MainLayoutScreen(),
        '/daftar-layanan': (context) => const DaftarLayananScreen(),
        '/daftar-pesanan': (context) => const DaftarPesananScreen(),
        '/kategori-layanan': (context) => const KategoriLayananScreen(),
      },
    );
  }
}
