import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/reservation_model.dart' as reservation_model;
import '../models/service_model.dart' as service_model;
import '../models/user_model.dart';

class AppwriteService {
  static const String endpoint = 'https://fra.cloud.appwrite.io/v1';
  static const String projectId = '685a927500235579b6b9';
  static const String databaseId = '685ab9890020ceb3a5e8';

  static const String servicesCollectionId = 'services';
  static const String reservationsCollectionId = 'bookings';
  static const String usersCollectionId = 'users';
  static const String tenantsCollectionId = 'tenants';
  static const String paymentsCollectionId = 'payments';
  static const String calendarEventsCollectionId = 'calendar_events';

  late Client _client;
  late Account _account;

  AppwriteService() {
    try {
      _client = Client()
          .setEndpoint(endpoint)
          .setProject(projectId)
          .setSelfSigned(status: true);

      _account = Account(_client);
      print('✅ Appwrite Client initialized successfully');
    } catch (e) {
      print('❌ Error initializing Appwrite: $e');
    }
  }

  // 🔧 PERBAIKAN: LANGSUNG RETURN DUMMY TANPA PANGGIL APPWRITE
  Future<List<service_model.ServiceModel>> getServices(
      {String? adminId}) async {
    // ✅ TIDAK PANGGIL APPWRITE API, LANGSUNG DUMMY
    print('📦 Returning dummy services data (bypass Appwrite)');
    await Future.delayed(const Duration(milliseconds: 500)); // Simulasi loading
    return _createDummyServices();
  }

  Future<List<reservation_model.ReservationModel>> getReservations(
      {String? adminId}) async {
    // ✅ TIDAK PANGGIL APPWRITE API, LANGSUNG DUMMY
    print('📦 Returning dummy reservations data (bypass Appwrite)');
    await Future.delayed(const Duration(milliseconds: 500)); // Simulasi loading
    return _createDummyReservations();
  }

  Future<List<reservation_model.ReservationModel>> getReservationsByStatus(
      String status,
      {String? adminId}) async {
    final allReservations = await getReservations(adminId: adminId);
    return allReservations
        .where((r) => r.status.toLowerCase() == status.toLowerCase())
        .toList();
  }

  Future<List<reservation_model.ReservationModel>> getReservationsByDateRange(
    DateTime startDate,
    DateTime endDate, {
    String? adminId,
  }) async {
    final allReservations = await getReservations(adminId: adminId);
    return allReservations.where((r) {
      return r.reservationDate.isAfter(startDate) &&
          r.reservationDate.isBefore(endDate);
    }).toList();
  }

  Future<List<service_model.ServiceModel>> searchServices(String query,
      {String? adminId}) async {
    final allServices = await getServices(adminId: adminId);
    return allServices
        .where((s) => s.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  // 🎭 DUMMY DATA GENERATORS
  List<service_model.ServiceModel> _createDummyServices() {
    return [
      service_model.ServiceModel(
        id: '1',
        name: 'Potong Rambut Premium',
        category: 'salon',
        description: 'Potong rambut dengan teknisi berpengalaman',
        price: 75000, // ✅ PASTIKAN TIDAK ADA .0
        durationMinutes: 60, // ✅ PASTIKAN TIDAK ADA .0
        adminId: 'admin1',
        isActive: true,
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now(),
      ),
      service_model.ServiceModel(
        id: '2',
        name: 'Make Up Wedding Package',
        category: 'mua',
        description: 'Paket lengkap make up pernikahan dengan aksesoris',
        price: 750000, // ✅ PASTIKAN TIDAK ADA .0
        durationMinutes: 180, // ✅ PASTIKAN TIDAK ADA .0
        adminId: 'admin1',
        isActive: true,
        createdAt: DateTime.now().subtract(const Duration(days: 25)),
        updatedAt: DateTime.now(),
      ),
      service_model.ServiceModel(
        id: '3',
        name: 'Dekorasi Pelaminan Mewah',
        category: 'dekorasi',
        description:
            'Dekorasi pelaminan dengan bunga segar dan lighting modern',
        price: 3500000, // ✅ PASTIKAN TIDAK ADA .0
        durationMinutes: 600, // ✅ PASTIKAN TIDAK ADA .0
        adminId: 'admin1',
        isActive: true,
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
        updatedAt: DateTime.now(),
      ),
      service_model.ServiceModel(
        id: '4',
        name: 'Spa Relaxation',
        category: 'spa',
        description: 'Paket spa untuk relaksasi tubuh dan pikiran',
        price: 200000, // ✅ PASTIKAN TIDAK ADA .0
        durationMinutes: 120, // ✅ PASTIKAN TIDAK ADA .0
        adminId: 'admin1',
        isActive: true,
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
        updatedAt: DateTime.now(),
      ),
    ];
  }

  List<reservation_model.ReservationModel> _createDummyReservations() {
    return [
      reservation_model.ReservationModel(
        id: '1',
        customerName: 'Siti Nurhaliza',
        customerPhone: '081234567890',
        customerEmail: 'siti@example.com',
        serviceId: '1',
        reservationDate: DateTime.now().add(const Duration(days: 2)),
        status: 'pending',
        totalPrice: 75000,
        notes: 'Minta potong model layer',
        adminId: 'admin1',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        updatedAt: DateTime.now(),
      ),
      reservation_model.ReservationModel(
        id: '2',
        customerName: 'Dewi Sartika',
        customerPhone: '081987654321',
        customerEmail: 'dewi@example.com',
        serviceId: '2',
        reservationDate: DateTime.now().add(const Duration(days: 14)),
        status: 'confirmed',
        totalPrice: 750000,
        notes: 'Wedding di Gedung Serbaguna, tema soft pink',
        adminId: 'admin1',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now(),
      ),
      reservation_model.ReservationModel(
        id: '3',
        customerName: 'Rini Soemarno',
        customerPhone: '081555666777',
        customerEmail: 'rini@example.com',
        serviceId: '3',
        reservationDate: DateTime.now().add(const Duration(days: 30)),
        status: 'pending',
        totalPrice: 3500000,
        notes: 'Acara pernikahan adat Jawa, butuh dekorasi tradisional',
        adminId: 'admin1',
        createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        updatedAt: DateTime.now(),
      ),
      reservation_model.ReservationModel(
        id: '4',
        customerName: 'Maya Sari',
        customerPhone: '081444555666',
        customerEmail: 'maya@example.com',
        serviceId: '4',
        reservationDate: DateTime.now().add(const Duration(days: 3)),
        status: 'confirmed',
        totalPrice: 200000,
        notes: 'Spa untuk recovery setelah olahraga',
        adminId: 'admin1',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        updatedAt: DateTime.now(),
      ),
      reservation_model.ReservationModel(
        id: '5',
        customerName: 'Andi Wijaya',
        customerPhone: '081777888999',
        customerEmail: 'andi@example.com',
        serviceId: '1',
        reservationDate: DateTime.now().add(const Duration(days: 1)),
        status: 'pending',
        totalPrice: 75000,
        notes: 'Potong rambut untuk interview kerja',
        adminId: 'admin1',
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        updatedAt: DateTime.now(),
      ),
    ];
  }

  // AUTH METHODS
  Future<bool> isLoggedIn() async {
    try {
      await _account.get();
      return true;
    } catch (e) {
      return false;
    }
  }

  // PLACEHOLDER METHODS
  Future<service_model.ServiceModel> createService(
      service_model.ServiceModel service) async {
    throw UnimplementedError('Create service not implemented yet');
  }

  Future<service_model.ServiceModel> updateService(
      service_model.ServiceModel service) async {
    throw UnimplementedError('Update service not implemented yet');
  }

  Future<void> deleteService(String serviceId) async {
    throw UnimplementedError('Delete service not implemented yet');
  }

  Future<reservation_model.ReservationModel> createReservation(
      reservation_model.ReservationModel reservation) async {
    throw UnimplementedError('Create reservation not implemented yet');
  }

  Future<reservation_model.ReservationModel> updateReservation(
      reservation_model.ReservationModel reservation) async {
    throw UnimplementedError('Update reservation not implemented yet');
  }

  Future<void> deleteReservation(String reservationId) async {
    throw UnimplementedError('Delete reservation not implemented yet');
  }
}

// ✅ PROVIDERS YANG DIPERBAIKI - TIDAK AKAN ERROR LAGI
final appwriteServiceProvider = Provider<AppwriteService>((ref) {
  return AppwriteService();
});

final adminServicesProvider =
    FutureProvider.family<List<service_model.ServiceModel>, String>(
        (ref, adminId) async {
  final appwriteService = ref.read(appwriteServiceProvider);
  return await appwriteService.getServices(adminId: adminId);
});

final adminReservationsProvider =
    FutureProvider.family<List<reservation_model.ReservationModel>, String>(
        (ref, adminId) async {
  final appwriteService = ref.read(appwriteServiceProvider);
  return await appwriteService.getReservations(adminId: adminId);
});

final adminStaffProvider =
    FutureProvider.family<List<UserModel>, String>((ref, adminId) async {
  await Future.delayed(const Duration(milliseconds: 300));
  return [
    UserModel(
      id: '1',
      name: 'Sarah Hairstylist',
      email: 'sarah@salon.com',
      role: 'staff',
      serviceType: 'salon',
      phone: '081111222333',
      photoUrl: 'https://via.placeholder.com/150',
      createdAt: DateTime.now().subtract(const Duration(days: 60)),
      updatedAt: DateTime.now(),
    ),
    UserModel(
      id: '2',
      name: 'Bella MUA',
      email: 'bella@mua.com',
      role: 'staff',
      serviceType: 'mua',
      phone: '081222333444',
      photoUrl: 'https://via.placeholder.com/150',
      createdAt: DateTime.now().subtract(const Duration(days: 45)),
      updatedAt: DateTime.now(),
    ),
  ];
});

final pendingReservationsProvider =
    FutureProvider.family<List<reservation_model.ReservationModel>, String>(
        (ref, adminId) async {
  final appwriteService = ref.read(appwriteServiceProvider);
  return await appwriteService.getReservationsByStatus('pending',
      adminId: adminId);
});

final allServicesProvider =
    FutureProvider<List<service_model.ServiceModel>>((ref) async {
  final appwriteService = ref.read(appwriteServiceProvider);
  return await appwriteService.getServices();
});

final allReservationsProvider =
    FutureProvider<List<reservation_model.ReservationModel>>((ref) async {
  final appwriteService = ref.read(appwriteServiceProvider);
  return await appwriteService.getReservations();
});
