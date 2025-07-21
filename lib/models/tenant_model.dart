import 'dart:convert';

class TenantModel {
  final String id;
  final String userId;
  final String businessName;
  final String businessType;
  final String address;
  final String phone;
  final String? email;
  final String? description;
  final String? logo;
  final Map<String, dynamic>? businessHours;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TenantModel({
    required this.id,
    required this.userId,
    required this.businessName,
    required this.businessType,
    required this.address,
    required this.phone,
    this.email,
    this.description,
    this.logo,
    this.businessHours,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TenantModel.fromMap(Map<String, dynamic> map) {
    return TenantModel(
      id: map['\$id'] ?? map['id'] ?? '',
      userId: map['user_id'] ?? '',
      businessName: map['business_name'] ?? '',
      businessType: map['business_type'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'],
      description: map['description'],
      logo: map['logo'],
      businessHours: map['business_hours'],
      isActive: map['is_active'] ?? true,
      createdAt: DateTime.parse(
        map['created_at'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        map['updated_at'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'business_name': businessName,
      'business_type': businessType,
      'address': address,
      'phone': phone,
      'email': email,
      'description': description,
      'logo': logo,
      'business_hours': businessHours,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());
  factory TenantModel.fromJson(String source) =>
      TenantModel.fromMap(json.decode(source));

  TenantModel copyWith({
    String? id,
    String? userId,
    String? businessName,
    String? businessType,
    String? address,
    String? phone,
    String? email,
    String? description,
    String? logo,
    Map<String, dynamic>? businessHours,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TenantModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      businessName: businessName ?? this.businessName,
      businessType: businessType ?? this.businessType,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      description: description ?? this.description,
      logo: logo ?? this.logo,
      businessHours: businessHours ?? this.businessHours,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'TenantModel(id: $id, businessName: $businessName, businessType: $businessType)';
  }
}
