import 'package:flutter/material.dart';
import '../models/reservation_model.dart';

class PendingReservationsList extends StatelessWidget {
  final List<ReservationModel> reservations;

  const PendingReservationsList({
    super.key,
    required this.reservations,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reservasi Tertunda',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (reservations.isNotEmpty)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${reservations.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            if (reservations.isEmpty)
              _buildEmptyState(context)
            else
              _buildReservationsList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: Column(
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 48,
              color: Colors.green[300],
            ),
            const SizedBox(height: 12),
            Text(
              'Tidak ada reservasi tertunda',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              'Semua reservasi sudah diproses',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[500],
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReservationsList(BuildContext context) {
    return Column(
      children: [
        ...reservations
            .take(5)
            .map((reservation) => _buildReservationItem(context, reservation)),
        if (reservations.length > 5) ...[
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey
                  .withValues(alpha: 0.1), // ✅ FIX: withOpacity → withValues
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '+${reservations.length - 5} reservasi lainnya',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              // Navigate to reservations page
            },
            child: const Text('Lihat Semua Reservasi'),
          ),
        ),
      ],
    );
  }

  Widget _buildReservationItem(
      BuildContext context, ReservationModel reservation) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.grey
                .withValues(alpha: 0.2)), // ✅ FIX: withOpacity → withValues
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: reservation.statusColor
                .withValues(alpha: 0.1), // ✅ FIX: withOpacity → withValues
            child: Icon(
              Icons.person,
              color: reservation.statusColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reservation.customerName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${reservation.formattedDate} • ${reservation.formattedTime}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                Text(
                  reservation.formattedPrice,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.check, color: Colors.green, size: 20),
                onPressed: () {
                  // Confirm reservation
                },
                tooltip: 'Konfirmasi',
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red, size: 20),
                onPressed: () {
                  // Cancel reservation
                },
                tooltip: 'Tolak',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
