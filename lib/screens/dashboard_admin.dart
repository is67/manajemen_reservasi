import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/session_provider.dart';
import '../providers/appwrite_service.dart'; // ✅ IMPORT PROVIDERS
import '../widgets/dashboard_drawer.dart';
import '../widgets/dashboard_stats_card.dart';
import '../widgets/reservations_chart.dart';
import '../widgets/pending_reservations_list.dart';

class DashboardAdminScreen extends ConsumerWidget {
  const DashboardAdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final user = session.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // ✅ GUNAKAN APPWRITE PROVIDERS
    final servicesAsync = ref.watch(adminServicesProvider(user.id));
    final reservationsAsync = ref.watch(adminReservationsProvider(user.id));
    final staffAsync = ref.watch(adminStaffProvider(user.id));
    final pendingReservationsAsync =
        ref.watch(pendingReservationsProvider(user.id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Admin'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(adminServicesProvider);
              ref.invalidate(adminReservationsProvider);
              ref.invalidate(adminStaffProvider);
              ref.invalidate(pendingReservationsProvider);
            },
          ),
        ],
      ),
      drawer: const DashboardDrawer(),
      body: SingleChildScrollView(
        // ✅ TAMBAH INI
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Connection Status
            _buildConnectionStatus(context),
            const SizedBox(height: 16),

            // Welcome Header
            _buildWelcomeHeader(context, user),
            const SizedBox(height: 24),

            // Chart Section
            servicesAsync.when(
              data: (services) => reservationsAsync.when(
                data: (reservations) => ReservationsChart(
                  reservations: reservations,
                  services: services,
                ),
                loading: () => const _LoadingCard(height: 250),
                error: (error, stack) => _ErrorCard(error: error.toString()),
              ),
              loading: () => const _LoadingCard(height: 250),
              error: (error, stack) => _ErrorCard(error: error.toString()),
            ),
            const SizedBox(height: 24),

            // Stats Section
            _buildStatsSection(
              context,
              servicesAsync,
              reservationsAsync,
              staffAsync,
            ),
            const SizedBox(height: 24),

            // Pending Reservations
            pendingReservationsAsync.when(
              data: (pendingReservations) => PendingReservationsList(
                reservations: pendingReservations,
              ),
              loading: () => const _LoadingCard(height: 200),
              error: (error, stack) => _ErrorCard(error: error.toString()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectionStatus(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.cloud_done, color: Colors.green[700]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Terhubung ke Appwrite Cloud (Collections: 6)',
              style: TextStyle(
                  color: Colors.green[700], fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader(BuildContext context, user) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                user.initials,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat Datang!',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Admin ${_getServiceTypeName(user.serviceType)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              _getServiceIcon(user.serviceType),
              size: 32,
              color: Theme.of(context).primaryColor.withValues(alpha: 0.7),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(
    BuildContext context,
    AsyncValue servicesAsync,
    AsyncValue reservationsAsync,
    AsyncValue staffAsync,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ringkasan Data',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
          children: [
            servicesAsync.when(
              data: (services) => DashboardStatsCard(
                title: 'Total Layanan',
                value: services.length.toString(),
                icon: Icons.design_services,
                color: Colors.blue,
                subtitle: 'Layanan aktif',
                onTap: () => Navigator.pushNamed(context, '/services'),
              ),
              loading: () => const _LoadingStatsCard(),
              error: (error, stack) => const _ErrorStatsCard(),
            ),
            staffAsync.when(
              data: (staff) => DashboardStatsCard(
                title: 'Staf Aktif',
                value: staff.length.toString(),
                icon: Icons.people,
                color: Colors.green,
                subtitle: 'Staf terdaftar',
                onTap: () => Navigator.pushNamed(context, '/staff'),
              ),
              loading: () => const _LoadingStatsCard(),
              error: (error, stack) => const _ErrorStatsCard(),
            ),
            reservationsAsync.when(
              data: (reservations) {
                final pendingCount = reservations
                    .where((r) => r.status.toLowerCase() == 'pending')
                    .length;
                return DashboardStatsCard(
                  title: 'Reservasi Tertunda',
                  value: pendingCount.toString(),
                  icon: Icons.pending_actions,
                  color: Colors.orange,
                  subtitle: 'Perlu konfirmasi',
                  onTap: () => Navigator.pushNamed(context, '/reservations'),
                );
              },
              loading: () => const _LoadingStatsCard(),
              error: (error, stack) => const _ErrorStatsCard(),
            ),
            reservationsAsync.when(
              data: (reservations) => DashboardStatsCard(
                title: 'Total Reservasi',
                value: reservations.length.toString(),
                icon: Icons.book_online,
                color: Colors.purple,
                subtitle: 'Semua status',
                onTap: () => Navigator.pushNamed(context, '/reservations'),
              ),
              loading: () => const _LoadingStatsCard(),
              error: (error, stack) => const _ErrorStatsCard(),
            ),
          ],
        ),
      ],
    );
  }

  String _getServiceTypeName(String serviceType) {
    switch (serviceType.toLowerCase()) {
      case 'salon':
        return 'Salon';
      case 'mua':
        return 'MUA';
      case 'dekorasi':
        return 'Dekorasi';
      case 'kostum':
        return 'Sewa Kostum';
      default:
        return 'Layanan';
    }
  }

  IconData _getServiceIcon(String serviceType) {
    switch (serviceType.toLowerCase()) {
      case 'salon':
        return Icons.content_cut;
      case 'mua':
        return Icons.face;
      case 'dekorasi':
        return Icons.auto_awesome;
      case 'kostum':
        return Icons.checkroom;
      default:
        return Icons.business;
    }
  }
}

// Loading and Error Widgets
class _LoadingCard extends StatelessWidget {
  final double height;

  const _LoadingCard({required this.height});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: height,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class _LoadingStatsCard extends StatelessWidget {
  const _LoadingStatsCard();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  final String error;

  const _ErrorCard({required this.error});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 48,
              ),
              const SizedBox(height: 8),
              Text(
                'Error: $error',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorStatsCard extends StatelessWidget {
  const _ErrorStatsCard();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Center(
        child: Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      ),
    );
  }
}
