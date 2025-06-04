// lib/services/appwrite_service.dart
import 'package:appwrite/appwrite.dart';

class AppwriteService {
  late final Client client;
  late final Account account;

  AppwriteService() {
    client = Client()
        .setEndpoint('https://fra.cloud.appwrite.io/v1') // <- Ganti sesuai file constants jika kamu mau
        .setProject('menajemen-reservasi')               // <- Project ID kamu
        .setSelfSigned(status: true); // opsional kalau kamu pakai self-hosted

    account = Account(client);
  }
}
