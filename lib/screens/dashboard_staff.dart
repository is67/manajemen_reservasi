import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/session_provider.dart';
import '../widgets/dashboard_drawer.dart';

class DashboardStaffScreen extends ConsumerWidget {
  const DashboardStaffScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionProvider);
    final user = session.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Staff'),
      ),
      drawer: const DashboardDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'Dashboard Staff',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text('Welcome ${user?.name ?? 'Staff'}'),
            const SizedBox(height: 16),
            const Text('Fitur ini akan segera dikembangkan'),
          ],
        ),
      ),
    );
  }
}
