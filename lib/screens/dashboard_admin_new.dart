import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/session_provider.dart';
import '../widgets/dashboard_drawer.dart';

// ✅ PASTIKAN CLASS INI ADA DAN EXPORT
class DashboardAdminNewScreen extends ConsumerWidget {
  const DashboardAdminNewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final user = session.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Admin (New)'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      drawer: const DashboardDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.dashboard,
                      size: 48,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dashboard Admin (Version 2)',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'User: ${user?.name ?? 'Guest'}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Back Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/');
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali ke Dashboard Utama'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Stats Cards Section
            Text(
              'Statistik',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildStatsCard(
                    context,
                    title: 'Total Layanan',
                    value: '15',
                    icon: Icons.design_services,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatsCard(
                    context,
                    title: 'Reservasi Hari Ini',
                    value: '8',
                    icon: Icons.today,
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildStatsCard(
                    context,
                    title: 'Pending',
                    value: '3',
                    icon: Icons.pending,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatsCard(
                    context,
                    title: 'Revenue',
                    value: 'Rp 2.5M',
                    icon: Icons.monetization_on,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Chart Section
            Text(
              'Grafik Reservasi Mingguan',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 200,
              child: _buildChart(context),
            ),

            const SizedBox(height: 24),

            // Recent Reservations Section
            Text(
              'Reservasi Terbaru',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 300,
              child: _buildRecentReservations(context),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ STATS CARD WIDGET (TANPA withOpacity)
  Widget _buildStatsCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100], // ✅ GANTI dengan abu-abu
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 16),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ CHART WIDGET (SIMPLE BAR CHART)
  Widget _buildChart(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildBar('Sen', 50, Colors.blue),
                  _buildBar('Sel', 80, Colors.green),
                  _buildBar('Rab', 30, Colors.orange),
                  _buildBar('Kam', 90, Colors.purple),
                  _buildBar('Jum', 70, Colors.red),
                  _buildBar('Sab', 60, Colors.teal),
                  _buildBar('Min', 40, Colors.indigo),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Reservasi per Hari (Minggu Ini)',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(String day, double height, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 20,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  // ✅ RECENT RESERVATIONS LIST (TANPA withOpacity)
  Widget _buildRecentReservations(BuildContext context) {
    final dummyReservations = [
      {
        'name': 'John Doe',
        'service': 'Potong Rambut',
        'time': '10:00',
        'status': 'Confirmed',
        'color': Colors.green,
      },
      {
        'name': 'Jane Smith',
        'service': 'Make Up Wedding',
        'time': '14:00',
        'status': 'Pending',
        'color': Colors.orange,
      },
      {
        'name': 'Bob Johnson',
        'service': 'Spa Treatment',
        'time': '16:00',
        'status': 'Completed',
        'color': Colors.blue,
      },
      {
        'name': 'Alice Brown',
        'service': 'Nail Art',
        'time': '11:30',
        'status': 'Cancelled',
        'color': Colors.red,
      },
      {
        'name': 'Charlie Wilson',
        'service': 'Facial Treatment',
        'time': '13:00',
        'status': 'Confirmed',
        'color': Colors.green,
      },
    ];

    return Card(
      child: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: dummyReservations.length,
        itemBuilder: (context, index) {
          final reservation = dummyReservations[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[200], // ✅ GANTI dengan abu-abu
              child: Text(
                (reservation['name'] as String)[0],
                style: TextStyle(
                  color: reservation['color'] as Color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(reservation['name'] as String),
            subtitle:
                Text('${reservation['service']} - ${reservation['time']}'),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[100], // ✅ GANTI dengan abu-abu
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                reservation['status'] as String,
                style: TextStyle(
                  color: reservation['color'] as Color,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Detail reservasi ${reservation['name']}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
