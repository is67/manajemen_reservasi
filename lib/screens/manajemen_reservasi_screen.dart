import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ManajemenReservasiScreen extends ConsumerStatefulWidget {
  const ManajemenReservasiScreen({super.key});

  @override
  ConsumerState<ManajemenReservasiScreen> createState() =>
      _ManajemenReservasiScreenState();
}

class _ManajemenReservasiScreenState
    extends ConsumerState<ManajemenReservasiScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _currentPage = 'Dashboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[400],
        title: Text(
          _getPageTitle(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                const Icon(Icons.person, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'admin',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    // Logout functionality
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ],
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.business,
                            color: Colors.lightBlue[400],
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
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
                    icon: Icons.dashboard,
                    title: 'Dashboard',
                    isSelected: _currentPage == 'Dashboard',
                    onTap: () => _navigateToPage('Dashboard'),
                  ),
                  _buildMenuItem(
                    icon: Icons.shopping_cart,
                    title: 'Pesanan',
                    isSelected: _currentPage == 'Pesanan',
                    onTap: () => _navigateToPage('Pesanan'),
                    hasSubmenu: true,
                    submenuItems: [
                      _buildSubmenuItem(
                        title: 'Schedule Layanan',
                        onTap: () => _navigateToPage('Schedule Layanan'),
                        isSelected: _currentPage == 'Schedule Layanan',
                      ),
                      _buildSubmenuItem(
                        title: 'Kalender Penyediaan',
                        onTap: () => _navigateToPage('Kalender Penyediaan'),
                        isSelected: _currentPage == 'Kalender Penyediaan',
                      ),
                    ],
                  ),
                  _buildMenuItem(
                    icon: Icons.event_available,
                    title: 'Reservasi',
                    isSelected: _currentPage == 'Reservasi',
                    onTap: () => _navigateToPage('Reservasi'),
                  ),
                  _buildMenuItem(
                    icon: Icons.payment,
                    title: 'Pembayaran',
                    isSelected: _currentPage == 'Pembayaran',
                    onTap: () => _navigateToPage('Pembayaran'),
                  ),
                  _buildMenuItem(
                    icon: Icons.design_services,
                    title: 'Manajemen Layanan',
                    isSelected: _currentPage == 'Manajemen Layanan',
                    onTap: () => _navigateToPage('Manajemen Layanan'),
                  ),
                  _buildMenuItem(
                    icon: Icons.person,
                    title: 'Profil',
                    isSelected: _currentPage == 'Profil',
                    onTap: () => _navigateToPage('Profil'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: _buildPageContent(),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    bool hasSubmenu = false,
    List<Widget>? submenuItems,
  }) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: isSelected ? Colors.lightBlue[50] : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border:
                isSelected ? Border.all(color: Colors.lightBlue[200]!) : null,
          ),
          child: ListTile(
            dense: true,
            leading: Icon(
              icon,
              color: isSelected ? Colors.lightBlue[600] : Colors.grey[600],
              size: 20,
            ),
            title: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.lightBlue[600] : Colors.grey[700],
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 14,
              ),
            ),
            onTap: onTap,
          ),
        ),
        if (hasSubmenu &&
            submenuItems != null &&
            (isSelected || title == 'Pesanan'))
          ...submenuItems,
      ],
    );
  }

  Widget _buildSubmenuItem({
    required String title,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 8, top: 2, bottom: 2),
      decoration: BoxDecoration(
        color: isSelected ? Colors.lightBlue[50] : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.only(left: 32, right: 16),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.lightBlue[600] : Colors.grey[600],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontSize: 13,
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  void _navigateToPage(String pageName) {
    setState(() {
      _currentPage = pageName;
    });
    Navigator.pop(context); // Close drawer

    // Navigate to specific screens
    switch (pageName) {
      case 'Schedule Layanan':
        Navigator.pushNamed(context, '/daftar-pesanan');
        break;
      case 'Manajemen Layanan':
        Navigator.pushNamed(context, '/daftar-layanan');
        break;
      case 'Reservasi':
        Navigator.pushNamed(context, '/reservations');
        break;
      case 'Pembayaran':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Fitur Pembayaran akan segera tersedia')),
        );
        break;
      case 'Profil':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Fitur Profil akan segera tersedia')),
        );
        break;
    }
  }

  String _getPageTitle() {
    switch (_currentPage) {
      case 'Schedule Layanan':
        return 'Schedule Layanan';
      case 'Manajemen Layanan':
        return 'Daftar Layanan';
      case 'Reservasi':
        return 'Reservasi';
      case 'Pembayaran':
        return 'Pembayaran';
      case 'Profil':
        return 'Profil';
      default:
        return 'Manajemen Reservasi';
    }
  }

  Widget _buildPageContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.phone_android,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          Text(
            'Halaman $_currentPage',
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
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue[400],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Buka Menu Navigasi'),
          ),
        ],
      ),
    );
  }
}
