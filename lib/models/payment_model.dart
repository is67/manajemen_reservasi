import 'package:flutter/material.dart';

class PaymentModel {
  final String id;
  final String reservationId;
  final double amount;
  final String paymentMethod;
  final String status;
  final String? transactionId;
  final String? notes;
  final DateTime? paidAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PaymentModel({
    required this.id,
    required this.reservationId,
    required this.amount,
    required this.paymentMethod,
    required this.status,
    this.transactionId,
    this.notes,
    this.paidAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      id: map['\$id'] ?? map['id'] ?? '',
      reservationId: map['reservation_id'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      paymentMethod: map['payment_method'] ?? 'cash',
      status: map['status'] ?? 'unpaid',
      transactionId: map['transaction_id'],
      notes: map['notes'],
      paidAt: map['paid_at'] != null ? DateTime.parse(map['paid_at']) : null,
      createdAt:
          DateTime.parse(map['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(map['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'reservation_id': reservationId,
      'amount': amount,
      'payment_method': paymentMethod,
      'status': status,
      'transaction_id': transactionId,
      'notes': notes,
      'paid_at': paidAt?.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  String get formattedAmount =>
      'Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}';

  String get statusText {
    switch (status.toLowerCase()) {
      case 'paid':
        return 'Lunas';
      case 'partial':
        return 'Sebagian';
      case 'refunded':
        return 'Dikembalikan';
      case 'failed':
        return 'Gagal';
      default:
        return 'Belum Bayar';
    }
  }

  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'partial':
        return Colors.orange;
      case 'refunded':
        return Colors.blue;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String get paymentMethodText {
    switch (paymentMethod.toLowerCase()) {
      case 'cash':
        return 'Tunai';
      case 'transfer':
        return 'Transfer';
      case 'credit_card':
        return 'Kartu Kredit';
      case 'debit_card':
        return 'Kartu Debit';
      case 'ewallet':
        return 'E-Wallet';
      default:
        return paymentMethod.toUpperCase();
    }
  }

  PaymentModel copyWith({
    String? id,
    String? reservationId,
    double? amount,
    String? paymentMethod,
    String? status,
    String? transactionId,
    String? notes,
    DateTime? paidAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PaymentModel(
      id: id ?? this.id,
      reservationId: reservationId ?? this.reservationId,
      amount: amount ?? this.amount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      transactionId: transactionId ?? this.transactionId,
      notes: notes ?? this.notes,
      paidAt: paidAt ?? this.paidAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'PaymentModel(id: $id, amount: $amount, status: $status)';
  }
}
