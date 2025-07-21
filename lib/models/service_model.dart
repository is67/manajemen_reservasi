class ServiceModel {
  final String id;
  final String name;
  final String category;
  final String description;
  final int price; // ✅ PASTIKAN INI int
  final int durationMinutes; // ✅ PASTIKAN INI int
  final String adminId;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  ServiceModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.durationMinutes,
    required this.adminId,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] is int)
          ? json['price']
          : (json['price'] as double).toInt(), // ✅ CONVERT JIKA PERLU
      durationMinutes: (json['durationMinutes'] is int)
          ? json['durationMinutes']
          : (json['durationMinutes'] as double).toInt(), // ✅ CONVERT JIKA PERLU
      adminId: json['adminId'] ?? '',
      isActive: json['isActive'] ?? true,
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'price': price,
      'durationMinutes': durationMinutes,
      'adminId': adminId,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

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
}
