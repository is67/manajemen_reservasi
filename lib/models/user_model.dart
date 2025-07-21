import 'dart:convert';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String serviceType;
  final String photoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.serviceType,
    required this.photoUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  // ✅ INI METHOD YANG DIBUTUHKAN APPWRITE SERVICE
  factory UserModel.fromAppwriteDocument(Map<String, dynamic> data) {
    return UserModel(
      id: data['\$id'] ?? '',
      name: data['full_name'] ?? 'Unknown User',
      email: data['email'] ?? '',
      phone: '',
      role: data['role'] ?? 'user',
      serviceType: data['service_type'] ?? '',
      photoUrl: data['photo'] ?? '',
      createdAt: DateTime.tryParse(data['\$createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(data['\$updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['\$id'] ?? map['id'] ?? '',
      name: map['name'] ?? map['full_name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      role: map['role'] ?? 'user',
      serviceType: map['service_type'] ?? '',
      photoUrl: map['photo_url'] ?? map['photo'] ?? '',
      createdAt: DateTime.tryParse(map['created_at'] ?? map['\$createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? map['\$updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'service_type': serviceType,
      'photo_url': photoUrl,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? role,
    String? serviceType,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      serviceType: serviceType ?? this.serviceType,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String get initials {
    final words = name.trim().split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    } else if (words.isNotEmpty) {
      return words[0][0].toUpperCase();
    }
    return 'U';
  }

  bool get isAdmin => role.toLowerCase() == 'admin';
  bool get isStaff => role.toLowerCase() == 'staff';

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
