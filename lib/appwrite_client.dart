import 'package:appwrite/appwrite.dart';

class AppwriteClient {
  static Client client = Client()
    ..setEndpoint('https://cloud.appwrite.io/v1') // URL endpoint Appwrite kamu
    ..setProject('menajemen-reservasi'); // Project ID kamu
}
