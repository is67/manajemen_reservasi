import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../models/tenant_model.dart';

class SessionState {
  final UserModel? currentUser;
  final TenantModel? currentTenant;
  final bool isLoggedIn;
  final bool isLoading;

  SessionState({
    this.currentUser,
    this.currentTenant,
    this.isLoggedIn = false,
    this.isLoading = false,
  });

  SessionState copyWith({
    UserModel? currentUser,
    TenantModel? currentTenant,
    bool? isLoggedIn,
    bool? isLoading,
  }) {
    return SessionState(
      currentUser: currentUser ?? this.currentUser,
      currentTenant: currentTenant ?? this.currentTenant,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class SessionNotifier extends StateNotifier<SessionState> {
  SessionNotifier() : super(SessionState()) {
    // Auto login as demo admin for development
    _initializeDemoSession();
  }

  void _initializeDemoSession() {
    final demoUser = UserModel(
      id: 'admin-demo-001',
      name: 'Admin Demo',
      email: 'admin@salon-demo.com',
      phone: '081234567890',
      role: 'admin',
      serviceType: 'salon',
      photoUrl: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final demoTenant = TenantModel(
      id: 'tenant-001',
      userId: 'admin-demo-001',
      businessName: 'Salon Cantik Demo',
      businessType: 'salon',
      address: 'Jl. Contoh No. 123, Jakarta',
      phone: '081234567890',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    state = state.copyWith(
      currentUser: demoUser,
      currentTenant: demoTenant,
      isLoggedIn: true,
    );
  }

  void setCurrentUser(UserModel user) {
    state = state.copyWith(currentUser: user, isLoggedIn: true);
  }

  void setCurrentTenant(TenantModel tenant) {
    state = state.copyWith(currentTenant: tenant);
  }

  void logout() {
    state = SessionState();
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }
}

final sessionProvider = StateNotifierProvider<SessionNotifier, SessionState>((
  ref,
) {
  return SessionNotifier();
});
