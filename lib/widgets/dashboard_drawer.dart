import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/session_provider.dart';

class DashboardDrawer extends ConsumerWidget {
  const DashboardDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final user = session.currentUser;

    return Drawer(
      child: Column(
        children: [
          // Header
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            accountName: Text(
              user?.name ?? 'Admin',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            accountEmail: Text(user?.email ?? 'admin@demo.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                user?.initials ?? 'A',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            otherAccountsPictures: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(
                      alpha: 0.2), // ✅ FIX: withOpacity → withValues
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  _getServiceIcon(user?.serviceType ?? 'salon'),
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(
                  context,
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  route: '/',
                  isSelected: ModalRoute.of(context)?.settings.name == '/',
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.book_online,
                  title: 'Reservasi',
                  route: '/reservations',
                  isSelected:
                      ModalRoute.of(context)?.settings.name == '/reservations',
                ),
                ListTile(
                  leading: const Icon(Icons.design_services),
                  title: const Text('Layanan Saya'),
                  onTap: () {
                    Navigator.pushNamed(context, '/layanan-saya');
                  },
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.people,
                  title: 'Staf Saya',
                  route: '/staff',
                  isSelected: ModalRoute.of(context)?.settings.name == '/staff',
                ),
                const Divider(),
                _buildMenuItem(
                  context,
                  icon: Icons.analytics,
                  title: 'Laporan',
                  route: '/reports',
                  isSelected: false,
                  enabled: false,
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.settings,
                  title: 'Pengaturan',
                  route: '/settings',
                  isSelected: false,
                  enabled: false,
                ),
              ],
            ),
          ),

          // Footer
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Divider(),
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: Colors.grey[600],
                    ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
    required bool isSelected,
    bool enabled = true,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected
              ? Theme.of(context).primaryColor
              : enabled
                  ? Colors.grey[700]
                  : Colors.grey[400],
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected
                ? Theme.of(context).primaryColor
                : enabled
                    ? Colors.grey[800]
                    : Colors.grey[400],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        selectedTileColor: Theme.of(context)
            .primaryColor
            .withValues(alpha: 0.1), // ✅ FIX: withOpacity → withValues
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabled: enabled,
        onTap: enabled
            ? () {
                Navigator.pop(context);
                if (!isSelected) {
                  Navigator.pushNamed(context, route);
                }
              }
            : null,
      ),
    );
  }

  IconData _getServiceIcon(String serviceType) {
    switch (serviceType.toLowerCase()) {
      case 'salon':
        return Icons.content_cut;
      case 'mua':
        return Icons.face;
      case 'dekorasi':
        return Icons
            .auto_awesome; // ✅ FIX: Icons.decoration → Icons.auto_awesome
      case 'kostum':
        return Icons.checkroom;
      default:
        return Icons.business;
    }
  }
}
