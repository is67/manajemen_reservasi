import 'package:flutter/material.dart';

class ReservationModel {
  final String id;
  final String serviceId;
  final String adminId;
  final String customerName;
  final String customerPhone;
  final String customerEmail;
  final DateTime reservationDate;
  final String status;
  final String notes;
  final double totalPrice;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ReservationModel({
    required this.id,
    required this.serviceId,
    required this.adminId,
    required this.customerName,
    required this.customerPhone,
    required this.customerEmail,
    required this.reservationDate,
    required this.status,
    required this.notes,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  // ✅ METHOD UNTUK APPWRITE DOCUMENT
  factory ReservationModel.fromAppwriteDocument(Map<String, dynamic> data) {
    return ReservationModel(
      id: data['\$id'] ?? '',
      serviceId: data['service_id'] ?? '',
      adminId: data['tenant_id'] ?? '',
      customerName: data['customer_name'] ?? 'Unknown Customer',
      customerPhone: data['customer_phone'] ?? '',
      customerEmail: data['customer_address'] ?? '',
      reservationDate:
          DateTime.tryParse(data['schedule_date'] ?? '') ?? DateTime.now(),
      status: data['payment_status'] ?? 'pending',
      notes: '',
      totalPrice: 0.0,
      createdAt: DateTime.tryParse(data['\$createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(data['\$updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  factory ReservationModel.fromMap(Map<String, dynamic> map) {
    return ReservationModel(
      id: map['\$id'] ?? map['id'] ?? '',
      serviceId: map['service_id'] ?? '',
      adminId: map['admin_id'] ?? '',
      customerName: map['customer_name'] ?? '',
      customerPhone: map['customer_phone'] ?? '',
      customerEmail: map['customer_email'] ?? '',
      reservationDate:
          DateTime.tryParse(map['reservation_date'] ?? '') ?? DateTime.now(),
      status: map['status'] ?? 'pending',
      notes: map['notes'] ?? '',
      totalPrice: (map['total_price'] ?? 0).toDouble(),
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'service_id': serviceId,
      'admin_id': adminId,
      'customer_name': customerName,
      'customer_phone': customerPhone,
      'customer_email': customerEmail,
      'reservation_date': reservationDate.toIso8601String(),
      'status': status,
      'notes': notes,
      'total_price': totalPrice,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  String get formattedDate {
    return '${reservationDate.day}/${reservationDate.month}/${reservationDate.year}';
  }

  String get formattedTime {
    return '${reservationDate.hour.toString().padLeft(2, '0')}:${reservationDate.minute.toString().padLeft(2, '0')}';
  }

  String get formattedPrice =>
      'Rp ${totalPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';

  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'confirmed':
      case 'paid':
        return const Color(0xFF4CAF50);
      case 'cancelled':
        return const Color(0xFFF44336);
      case 'completed':
        return const Color(0xFF2196F3);
      default:
        return const Color(0xFFFF9800);
    }
  }

  String get statusText {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Menunggu';
      case 'confirmed':
      case 'paid':
        return 'Dikonfirmasi';
      case 'cancelled':
        return 'Dibatalkan';
      case 'completed':
        return 'Selesai';
      default:
        return status.toUpperCase();
    }
  }

  ReservationModel copyWith({
    String? id,
    String? serviceId,
    String? adminId,
    String? customerName,
    String? customerPhone,
    String? customerEmail,
    DateTime? reservationDate,
    String? status,
    String? notes,
    double? totalPrice,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ReservationModel(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      adminId: adminId ?? this.adminId,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      customerEmail: customerEmail ?? this.customerEmail,
      reservationDate: reservationDate ?? this.reservationDate,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      totalPrice: totalPrice ?? this.totalPrice,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'ReservationModel(id: $id, customerName: $customerName, status: $status)';
  }
}
