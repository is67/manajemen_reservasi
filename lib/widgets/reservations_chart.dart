import 'package:flutter/material.dart';
import '../models/reservation_model.dart' as reservation_model;
import '../models/service_model.dart' as service_model;

class ReservationsChart extends StatelessWidget {
  final List<reservation_model.ReservationModel> reservations;
  final List<service_model.ServiceModel> services;

  const ReservationsChart({
    super.key,
    required this.reservations,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    if (services.isEmpty) {
      return const _EmptyChart(message: 'Belum ada layanan');
    }

    final chartData = _generateChartData();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statistik Reservasi per Layanan',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: chartData.isEmpty
                  ? const _EmptyChart(message: 'Belum ada data reservasi')
                  : _SimpleBarChart(data: chartData),
            ),
          ],
        ),
      ),
    );
  }

  List<ChartData> _generateChartData() {
    return services.map((service) {
      final count = reservations
          .where((reservation) => reservation.serviceId == service.id)
          .length;

      return ChartData(
        label: service.name,
        value: count.toDouble(),
        color: _getColorForService(service.category),
      );
    }).toList();
  }

  Color _getColorForService(String category) {
    switch (category.toLowerCase()) {
      case 'salon':
        return Colors.blue;
      case 'mua':
        return Colors.pink;
      case 'dekorasi':
        return Colors.green;
      case 'kostum':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

class ChartData {
  final String label;
  final double value;
  final Color color;

  ChartData({
    required this.label,
    required this.value,
    required this.color,
  });
}

class _SimpleBarChart extends StatelessWidget {
  final List<ChartData> data;

  const _SimpleBarChart({required this.data});

  @override
  Widget build(BuildContext context) {
    final maxValue = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: data.map((item) {
        final height = maxValue > 0 ? (item.value / maxValue) * 150 : 0.0;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  item.value.toInt().toString(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  height: height,
                  decoration: BoxDecoration(
                    color: item.color,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.label,
                  style: const TextStyle(fontSize: 10),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _EmptyChart extends StatelessWidget {
  final String message;

  const _EmptyChart({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bar_chart,
            size: 48,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
