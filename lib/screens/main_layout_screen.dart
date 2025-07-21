import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider untuk current page
final currentPageProvider = StateProvider<int>((ref) => 0);

// Provider untuk data layanan
final layananProvider = StateProvider<List<Map<String, dynamic>>>((ref) => [
      {
        'id': 1,
        'nama': 'Make Up Wedding Package',
        'kategori': 'Make Up Artist',
        'deskripsi': 'Paket lengkap make up pernikahan dengan aksesoris',
        'durasi': 180,
        'harga': 750000,
        'status': 'Aktif',
        'icon': Icons.face_retouching_natural,
        'color': Colors.purple,
      },
      {
        'id': 2,
        'nama': 'Dekorasi Pelaminan Mewah',
        'kategori': 'Dekorasi',
        'deskripsi':
            'Dekorasi pelaminan dengan bunga segar dan lighting modern',
        'durasi': 600,
        'harga': 3500000,
        'status': 'Aktif',
        'icon': Icons.auto_awesome,
        'color': Colors.orange,
      },
      {
        'id': 3,
        'nama': 'Spa Relaxation',
        'kategori': 'Spa & Wellness',
        'deskripsi': 'Paket spa untuk relaksasi tubuh dan pikiran',
        'durasi': 120,
        'harga': 200000,
        'status': 'Aktif',
        'icon': Icons.spa,
        'color': Colors.green,
      },
    ]);

// Provider untuk data staf
final stafProvider = StateProvider<List<Map<String, dynamic>>>((ref) => [
      {
        'id': 1,
        'nama': 'Sarah Hairstylist',
        'email': 'sarah@salon.com',
        'phone': '081111222333',
        'role': 'STAFF',
        'avatar': 'SH',
        'color': Colors.pink,
        'keahlian': ['Potong Rambut', 'Hair Styling', 'Hair Color'],
        'status': 'Aktif',
      },
      {
        'id': 2,
        'nama': 'Bella MUA',
        'email': 'bella@mua.com',
        'phone': '081222333444',
        'role': 'STAFF',
        'avatar': 'BM',
        'color': Colors.blue,
        'keahlian': ['Make Up Wedding', 'Make Up Party', 'Face Painting'],
        'status': 'Aktif',
      },
    ]);

class MainLayoutScreen extends ConsumerWidget {
  const MainLayoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPageIndex = ref.watch(currentPageProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[400],
        title: Text(
          _getPageTitle(currentPageIndex),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: _buildAppBarActions(context, ref, currentPageIndex),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            // Header Drawer
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.lightBlue[400],
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.business,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'SIAMAL',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Menu Items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildMenuItem(
                    context: context,
                    ref: ref,
                    icon: Icons.dashboard,
                    title: 'Dashboard',
                    index: 0,
                    currentIndex: currentPageIndex,
                  ),
                  _buildMenuItem(
                    context: context,
                    ref: ref,
                    icon: Icons.calendar_today,
                    title: 'Reservasi',
                    index: 1,
                    currentIndex: currentPageIndex,
                  ),
                  _buildMenuItem(
                    context: context,
                    ref: ref,
                    icon: Icons.build,
                    title: 'Layanan Saya',
                    index: 2,
                    currentIndex: currentPageIndex,
                  ),
                  _buildMenuItem(
                    context: context,
                    ref: ref,
                    icon: Icons.people,
                    title: 'Staf Saya',
                    index: 3,
                    currentIndex: currentPageIndex,
                  ),
                  _buildMenuItem(
                    context: context,
                    ref: ref,
                    icon: Icons.person,
                    title: 'Profil',
                    index: 4,
                    currentIndex: currentPageIndex,
                  ),
                  const Divider(),
                  _buildMenuItem(
                    context: context,
                    ref: ref,
                    icon: Icons.bar_chart,
                    title: 'Laporan',
                    index: 5,
                    currentIndex: currentPageIndex,
                    isDisabled: true,
                  ),
                  _buildMenuItem(
                    context: context,
                    ref: ref,
                    icon: Icons.settings,
                    title: 'Pengaturan',
                    index: 6,
                    currentIndex: currentPageIndex,
                    isDisabled: true,
                  ),
                ],
              ),
            ),

            // Footer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(
                    'Versi 1.0.0',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: _getPageContent(currentPageIndex, ref, context),
      floatingActionButton:
          _buildFloatingActionButton(context, ref, currentPageIndex),
    );
  }

  List<Widget>? _buildAppBarActions(
      BuildContext context, WidgetRef ref, int currentPageIndex) {
    if (currentPageIndex == 2 || currentPageIndex == 3) {
      return [
        IconButton(
          icon: const Icon(Icons.add, color: Colors.white),
          onPressed: () => _showAddDialog(context, ref, currentPageIndex),
        ),
      ];
    }
    return null;
  }

  Widget? _buildFloatingActionButton(
      BuildContext context, WidgetRef ref, int currentPageIndex) {
    if (currentPageIndex == 2 || currentPageIndex == 3) {
      return FloatingActionButton(
        onPressed: () => _showAddDialog(context, ref, currentPageIndex),
        backgroundColor: Colors.lightBlue[400],
        child: const Icon(Icons.add, color: Colors.white),
      );
    }
    return null;
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required WidgetRef ref,
    required IconData icon,
    required String title,
    required int index,
    required int currentIndex,
    bool isDisabled = false,
  }) {
    final isSelected = currentIndex == index;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? Colors.lightBlue[50] : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(
          icon,
          color: isSelected
              ? Colors.lightBlue[600]
              : isDisabled
                  ? Colors.grey[400]
                  : Colors.grey[600],
          size: 20,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected
                ? Colors.lightBlue[600]
                : isDisabled
                    ? Colors.grey[400]
                    : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 14,
          ),
        ),
        onTap: isDisabled
            ? () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Fitur $title akan segera tersedia'),
                    backgroundColor: Colors.orange,
                  ),
                );
              }
            : () {
                ref.read(currentPageProvider.notifier).state = index;
                Navigator.pop(context);
              },
      ),
    );
  }

  String _getPageTitle(int index) {
    switch (index) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Manajemen Reservasi';
      case 2:
        return 'Layanan Saya';
      case 3:
        return 'Manajemen Staf';
      case 4:
        return 'Profil Saya';
      case 5:
        return 'Laporan';
      case 6:
        return 'Pengaturan';
      default:
        return 'Dashboard';
    }
  }

  Widget _getPageContent(int index, WidgetRef ref, BuildContext context) {
    switch (index) {
      case 0:
        return _buildDashboardContent(ref);
      case 1:
        return _buildReservationContent(ref);
      case 2:
        return _buildLayananContent(ref, context);
      case 3:
        return _buildStafContent(ref, context);
      case 4:
        return _buildProfilContent(ref, context);
      case 5:
      case 6:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getPageIcon(index),
                size: 80,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 20),
              Text(
                'Halaman ${_getPageTitle(index)}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Fitur ini akan segera dikembangkan',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        );
      default:
        return _buildDashboardContent(ref);
    }
  }

  IconData _getPageIcon(int index) {
    switch (index) {
      case 5:
        return Icons.bar_chart;
      case 6:
        return Icons.settings;
      default:
        return Icons.phone_android;
    }
  }

  Widget _buildDashboardContent(WidgetRef ref) {
    final layananList = ref.watch(layananProvider);
    final stafList = ref.watch(stafProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ STATS CARDS YANG BISA DIKLIK - UPDATE CALLBACK
          Row(
            children: [
              Expanded(
                child: Builder(
                  builder: (context) => _buildClickableStatCard(
                    context: context,
                    ref: ref,
                    title: 'Total Layanan',
                    value: '${layananList.length}',
                    icon: Icons.design_services,
                    color: Colors.blue,
                    onTap: () =>
                        _navigateToLayanan(ref, context), // ✅ TAMBAH CONTEXT
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Builder(
                  builder: (context) => _buildClickableStatCard(
                    context: context,
                    ref: ref,
                    title: 'Total Staf',
                    value: '${stafList.length}',
                    icon: Icons.people,
                    color: Colors.green,
                    onTap: () =>
                        _navigateToStaf(ref, context), // ✅ TAMBAH CONTEXT
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Builder(
                  builder: (context) => _buildClickableStatCard(
                    context: context,
                    ref: ref,
                    title: 'Pending',
                    value: '3',
                    icon: Icons.hourglass_empty,
                    color: Colors.orange,
                    onTap: () => _navigateToReservasi(ref, context,
                        filter: 'pending'), // ✅ TAMBAH CONTEXT
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Builder(
                  builder: (context) => _buildClickableStatCard(
                    context: context,
                    ref: ref,
                    title: 'Selesai',
                    value: '25',
                    icon: Icons.check_circle,
                    color: Colors.purple,
                    onTap: () => _navigateToReservasi(ref, context,
                        filter: 'completed'), // ✅ TAMBAH CONTEXT
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // ✅ HEADER RESERVASI TERBARU DENGAN TOMBOL LIHAT SEMUA
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Reservasi Terbaru',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              Builder(
                builder: (context) => TextButton.icon(
                  onPressed: () =>
                      _navigateToReservasi(ref, context), // ✅ TAMBAH CONTEXT
                  icon: const Icon(Icons.arrow_forward, size: 16),
                  label: const Text('Lihat Semua'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.lightBlue[600],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // ✅ CONTAINER RESERVASI YANG BISA DIKLIK
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Builder(
                  builder: (context) => _buildClickableReservationItem(
                    context: context,
                    ref: ref,
                    customerName: 'Siti Nurhaliza',
                    serviceName: 'Potong Rambut',
                    status: 'Pending',
                    reservationId: 'RV001',
                  ),
                ),
                Builder(
                  builder: (context) => _buildClickableReservationItem(
                    context: context,
                    ref: ref,
                    customerName: 'Dewi Sartika',
                    serviceName: 'Make Up Wedding',
                    status: 'Confirmed',
                    reservationId: 'RV002',
                  ),
                ),
                Builder(
                  builder: (context) => _buildClickableReservationItem(
                    context: context,
                    ref: ref,
                    customerName: 'Maya Sari',
                    serviceName: 'Spa Package',
                    status: 'Confirmed',
                    reservationId: 'RV003',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ✅ STAT CARD YANG BISA DIKLIK
  Widget _buildClickableStatCard({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
          // ✅ TAMBAH BORDER SAAT HOVER
          border: Border.all(
            color: Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            // ✅ INDIKATOR KLIK
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ✅ RESERVASI ITEM YANG BISA DIKLIK
  Widget _buildClickableReservationItem({
    required BuildContext context,
    required WidgetRef ref,
    required String customerName,
    required String serviceName,
    required String status,
    required String reservationId,
  }) {
    Color statusColor = status == 'Pending' ? Colors.orange : Colors.green;

    return InkWell(
      onTap: () => _showReservationDetailDialog(
          context, ref, reservationId, customerName, serviceName, status),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[200]!),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: statusColor.withValues(alpha: 0.1),
              child: Icon(
                status == 'Pending'
                    ? Icons.hourglass_empty
                    : Icons.check_circle,
                color: statusColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customerName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    serviceName,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'ID: $reservationId',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Colors.grey[400],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ✅ FUNGSI NAVIGASI - TAMBAH PARAMETER CONTEXT
  void _navigateToLayanan(WidgetRef ref, BuildContext context) {
    ref.read(currentPageProvider.notifier).state =
        2; // Index untuk Layanan Saya
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Menuju ke halaman Layanan Saya'),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _navigateToStaf(WidgetRef ref, BuildContext context) {
    ref.read(currentPageProvider.notifier).state = 3; // Index untuk Staf Saya
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Menuju ke halaman Manajemen Staf'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
      ),
    );
  }

  void _navigateToReservasi(WidgetRef ref, BuildContext context,
      {String? filter}) {
    ref.read(currentPageProvider.notifier).state = 1; // Index untuk Reservasi
    String message = 'Menuju ke halaman Reservasi';
    if (filter != null) {
      message += ' (Filter: $filter)';
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // ✅ DIALOG DETAIL RESERVASI - UPDATE CALLBACK
  void _showReservationDetailDialog(
    BuildContext context,
    WidgetRef ref,
    String reservationId,
    String customerName,
    String serviceName,
    String status,
  ) {
    Color statusColor = status == 'Pending' ? Colors.orange : Colors.green;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.calendar_today, color: Colors.lightBlue[600]),
            const SizedBox(width: 8),
            const Text('Detail Reservasi'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('ID Reservasi', reservationId),
            _buildDetailRow('Nama Customer', customerName),
            _buildDetailRow('Layanan', serviceName),
            _buildDetailRow('Tanggal', '25 Juli 2025'),
            _buildDetailRow('Waktu', '14:00 - 16:00'),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Status: ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          if (status == 'Pending') ...[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _showConfirmDialog(context, 'Tolak Reservasi',
                    'Apakah Anda yakin ingin menolak reservasi ini?');
              },
              child: const Text('Tolak', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showConfirmDialog(context, 'Konfirmasi Reservasi',
                    'Apakah Anda yakin ingin mengkonfirmasi reservasi ini?');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: const Text('Konfirmasi'),
            ),
          ],
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToReservasi(ref, context); // ✅ TAMBAH CONTEXT
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue[400],
              foregroundColor: Colors.white,
            ),
            child: const Text('Lihat Semua'),
          ),
        ],
      ),
    );
  }

  // ✅ DIALOG KONFIRMASI
  void _showConfirmDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$title berhasil!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue[400],
              foregroundColor: Colors.white,
            ),
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Keluar'),
        content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Berhasil keluar dari aplikasi'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
  }

  // ✅ RESERVASI CONTENT
  Widget _buildReservationContent(WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: const Text('Tambah Reservasi'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[400],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list),
                  label: const Text('Filter'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.lightBlue[400],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildReservationItem(
                    'Siti Nurhaliza', 'Potong Rambut Premium', 'Pending'),
                _buildReservationItem(
                    'Dewi Sartika', 'Make Up Wedding Package', 'Confirmed'),
                _buildReservationItem(
                    'Rini Soemarno', 'Dekorasi Pelaminan', 'Pending'),
                _buildReservationItem(
                    'Maya Sari', 'Spa Relaxation', 'Confirmed'),
                _buildReservationItem(
                    'Andi Wijaya', 'Potong Rambut Premium', 'Pending'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ✅ LAYANAN CONTENT
  Widget _buildLayananContent(WidgetRef ref, BuildContext context) {
    final layananList = ref.watch(layananProvider);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.lightBlue[400],
          ),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Cari layanan...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('Semua', true),
                    _buildFilterChip('Salon & Kecantikan', false),
                    _buildFilterChip('Make Up Artist', false),
                    _buildFilterChip('Dekorasi', false),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: layananList.length,
            itemBuilder: (context, index) {
              final layanan = layananList[index];
              return _buildLayananCard(layanan, ref, context);
            },
          ),
        ),
      ],
    );
  }

  // ✅ STAF CONTENT
  Widget _buildStafContent(WidgetRef ref, BuildContext context) {
    final stafList = ref.watch(stafProvider);

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: stafList.length,
      itemBuilder: (context, index) {
        final staf = stafList[index];
        return _buildStafCard(staf, ref, context);
      },
    );
  }

  // ✅ PROFIL CONTENT
  Widget _buildProfilContent(WidgetRef ref, BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.lightBlue[100],
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.lightBlue[600],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Ahmad Rois',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Administrator',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Fitur edit profil akan segera tersedia')),
                    );
                  },
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('Edit Profil'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[400],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                ListTile(
                  leading:
                      const Icon(Icons.notifications, color: Colors.orange),
                  title: const Text('Notifikasi'),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                    activeColor: Colors.lightBlue[400],
                  ),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.lock, color: Colors.red),
                  title: const Text('Ganti Password'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text(
                              'Fitur ganti password akan segera tersedia')),
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.grey),
                  title: const Text('Keluar'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ✅ FILTER CHIP
  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (value) {},
        backgroundColor: Colors.white.withValues(alpha: 0.2),
        selectedColor: Colors.white,
        labelStyle: TextStyle(
          color: isSelected ? Colors.lightBlue[600] : Colors.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  // ✅ LAYANAN CARD
  Widget _buildLayananCard(
      Map<String, dynamic> layanan, WidgetRef ref, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: layanan['color'].withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    layanan['icon'],
                    color: layanan['color'],
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        layanan['nama'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        layanan['kategori'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    if (value == 'edit') {
                      _showEditLayananDialog(context, ref, layanan);
                    } else if (value == 'delete') {
                      _showDeleteLayananDialog(context, ref, layanan);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 16),
                          SizedBox(width: 8),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 16, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Hapus', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              layanan['deskripsi'],
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  '${layanan['durasi']} menit',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(width: 16),
                Icon(Icons.attach_money, size: 16, color: Colors.green[600]),
                const SizedBox(width: 4),
                Text(
                  'Rp ${layanan['harga'].toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}',
                  style: TextStyle(
                    color: Colors.green[600],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    layanan['status'],
                    style: TextStyle(
                      color: Colors.green[700],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ✅ STAF CARD
  Widget _buildStafCard(
      Map<String, dynamic> staf, WidgetRef ref, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: staf['color'],
              child: Text(
                staf['avatar'],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    staf['nama'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    staf['email'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    staf['phone'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      staf['role'],
                      style: TextStyle(
                        color: Colors.green[700],
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuButton(
              onSelected: (value) {
                if (value == 'detail') {
                  _showStafDetailDialog(context, staf);
                } else if (value == 'edit') {
                  _showEditStafDialog(context, ref, staf);
                } else if (value == 'delete') {
                  _showDeleteStafDialog(context, ref, staf);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'detail',
                  child: Row(
                    children: [
                      Icon(Icons.info, size: 16),
                      SizedBox(width: 8),
                      Text('Detail'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 16),
                      SizedBox(width: 8),
                      Text('Edit'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 16, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Hapus', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ✅ RESERVASI ITEM (NON-CLICKABLE UNTUK HALAMAN RESERVASI)
  Widget _buildReservationItem(
      String customerName, String serviceName, String status) {
    Color statusColor = status == 'Pending' ? Colors.orange : Colors.green;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: statusColor.withValues(alpha: 0.1),
            child: Icon(
              status == 'Pending' ? Icons.hourglass_empty : Icons.check_circle,
              color: statusColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customerName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  serviceName,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ DIALOG FUNCTIONS
  void _showAddDialog(BuildContext context, WidgetRef ref, int pageIndex) {
    if (pageIndex == 2) {
      _showAddLayananDialog(context, ref);
    } else if (pageIndex == 3) {
      _showAddStafDialog(context, ref);
    }
  }

  void _showAddLayananDialog(BuildContext context, WidgetRef ref) {
    final namaController = TextEditingController();
    final kategoriController = TextEditingController();
    final deskripsiController = TextEditingController();
    final durasiController = TextEditingController();
    final hargaController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Layanan Baru'),
        content: SizedBox(
          width: 400,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Layanan',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: kategoriController,
                  decoration: const InputDecoration(
                    labelText: 'Kategori',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: deskripsiController,
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: durasiController,
                  decoration: const InputDecoration(
                    labelText: 'Durasi (menit)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: hargaController,
                  decoration: const InputDecoration(
                    labelText: 'Harga (Rp)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (namaController.text.isNotEmpty &&
                  kategoriController.text.isNotEmpty &&
                  deskripsiController.text.isNotEmpty &&
                  durasiController.text.isNotEmpty &&
                  hargaController.text.isNotEmpty) {
                final layananList = ref.read(layananProvider.notifier);
                final newLayanan = {
                  'id': DateTime.now().millisecondsSinceEpoch,
                  'nama': namaController.text,
                  'kategori': kategoriController.text,
                  'deskripsi': deskripsiController.text,
                  'durasi': int.parse(durasiController.text),
                  'harga': int.parse(hargaController.text),
                  'status': 'Aktif',
                  'icon': Icons.star,
                  'color': Colors.blue,
                };

                layananList.state = [...layananList.state, newLayanan];
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Layanan berhasil ditambahkan!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue[400],
              foregroundColor: Colors.white,
            ),
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }

  void _showAddStafDialog(BuildContext context, WidgetRef ref) {
    final namaController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Staf Baru'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              if (namaController.text.isNotEmpty &&
                  emailController.text.isNotEmpty &&
                  phoneController.text.isNotEmpty) {
                final stafList = ref.read(stafProvider.notifier);
                final newStaf = {
                  'id': DateTime.now().millisecondsSinceEpoch,
                  'nama': namaController.text,
                  'email': emailController.text,
                  'phone': phoneController.text,
                  'role': 'STAFF',
                  'avatar': namaController.text.substring(0, 2).toUpperCase(),
                  'color': Colors.teal,
                  'keahlian': [],
                  'status': 'Aktif',
                };

                stafList.state = [...stafList.state, newStaf];
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Staf berhasil ditambahkan!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue[400],
              foregroundColor: Colors.white,
            ),
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }

  void _showEditLayananDialog(
      BuildContext context, WidgetRef ref, Map<String, dynamic> layanan) {
    final namaController = TextEditingController(text: layanan['nama']);
    final kategoriController = TextEditingController(text: layanan['kategori']);
    final deskripsiController =
        TextEditingController(text: layanan['deskripsi']);
    final durasiController =
        TextEditingController(text: layanan['durasi'].toString());
    final hargaController =
        TextEditingController(text: layanan['harga'].toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Layanan'),
        content: SizedBox(
          width: 400,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namaController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Layanan',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: kategoriController,
                  decoration: const InputDecoration(
                    labelText: 'Kategori',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: deskripsiController,
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: durasiController,
                  decoration: const InputDecoration(
                    labelText: 'Durasi (menit)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: hargaController,
                  decoration: const InputDecoration(
                    labelText: 'Harga (Rp)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              final layananList = ref.read(layananProvider.notifier);
              final updatedList = layananList.state.map((item) {
                if (item['id'] == layanan['id']) {
                  return {
                    ...item,
                    'nama': namaController.text,
                    'kategori': kategoriController.text,
                    'deskripsi': deskripsiController.text,
                    'durasi': int.parse(durasiController.text),
                    'harga': int.parse(hargaController.text),
                  };
                }
                return item;
              }).toList();

              layananList.state = updatedList;
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Layanan berhasil diupdate!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue[400],
              foregroundColor: Colors.white,
            ),
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void _showDeleteLayananDialog(
      BuildContext context, WidgetRef ref, Map<String, dynamic> layanan) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Layanan'),
        content: Text(
            'Apakah Anda yakin ingin menghapus layanan "${layanan['nama']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              final layananList = ref.read(layananProvider.notifier);
              layananList.state = layananList.state
                  .where((item) => item['id'] != layanan['id'])
                  .toList();
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Layanan berhasil dihapus!'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void _showEditStafDialog(
      BuildContext context, WidgetRef ref, Map<String, dynamic> staf) {
    final namaController = TextEditingController(text: staf['nama']);
    final emailController = TextEditingController(text: staf['email']);
    final phoneController = TextEditingController(text: staf['phone']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Staf'),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                // ✅ TAMBAH TextField widget
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  labelText: 'Nomor Telepon',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              final stafList = ref.read(stafProvider.notifier);
              final updatedList = stafList.state.map((item) {
                if (item['id'] == staf['id']) {
                  return {
                    ...item,
                    'nama': namaController.text,
                    'email': emailController.text,
                    'phone': phoneController.text,
                    'avatar': namaController.text.substring(0, 2).toUpperCase(),
                  };
                }
                return item;
              }).toList();

              stafList.state = updatedList;
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Data staf berhasil diupdate!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue[400],
              foregroundColor: Colors.white,
            ),
            child: const Text('Simpan'),
          ),
        ],
      ),
    ); // ✅ TAMBAH CLOSING PARENTHESIS UNTUK showDialog
  }

  void _showDeleteStafDialog(
      BuildContext context, WidgetRef ref, Map<String, dynamic> staf) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Staf'),
        content:
            Text('Apakah Anda yakin ingin menghapus staf "${staf['nama']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              final stafList = ref.read(stafProvider.notifier);
              stafList.state = stafList.state
                  .where((item) => item['id'] != staf['id'])
                  .toList();
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Staf berhasil dihapus!'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  void _showStafDetailDialog(BuildContext context, Map<String, dynamic> staf) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Detail ${staf['nama']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: staf['color'],
                  child: Text(
                    staf['avatar'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        staf['nama'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        staf['role'],
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildDetailRow('Email', staf['email']),
            _buildDetailRow('Telepon', staf['phone']),
            _buildDetailRow('Status', staf['status']),
            const SizedBox(height: 16),
            Text(
              'Keahlian:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: (staf['keahlian'] as List)
                  .map((skill) => Chip(
                        label: Text(
                          skill,
                          style: const TextStyle(fontSize: 12),
                        ),
                        backgroundColor: Colors.blue[100],
                      ))
                  .toList(),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
} // ✅ TUTUP CLASS MainLayoutScreen
