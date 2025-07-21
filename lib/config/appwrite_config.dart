import 'package:appwrite/appwrite.dart';

class AppwriteConfig {
  // ✅ APPWRITE CONFIGURATION - REAL PROJECT
  static const String endpoint = 'https://fra.cloud.appwrite.io/v1';
  static const String projectId = '685a927500235579b6b9';

  // Database & Collections (sesuai dengan yang sudah ada)
  static const String databaseId = '685ab9890020ceb3a5e8';
  static const String usersCollection = 'users';
  static const String servicesCollection = 'services';
  static const String reservationsCollection =
      'bookings'; // ✅ GANTI ke 'bookings'
  static const String staffCollection =
      'users'; // ✅ Pakai collection users dengan filter role
  static const String paymentsCollection = 'payments';
  static const String tenantsCollection = 'tenants';
  static const String calendarEventsCollection = 'calendar_events';

  static Client client = Client();
  static late Account account;
  static late Databases database;
  static late Storage storage;

  static void initialize() {
    client.setEndpoint(endpoint).setProject(projectId);

    account = Account(client);
    database = Databases(client);
    storage = Storage(client);
  }
}

// User model attributes
const userAttributes = [
  {"key": "admin_id", "type": "string", "size": 100, "required": true},
  {"key": "name", "type": "string", "size": 255, "required": true},
  {"key": "email", "type": "string", "size": 255, "required": true},
  {"key": "phone", "type": "string", "size": 20, "required": true},
  {
    "key": "role",
    "type": "string",
    "size": 50,
    "required": true,
    "default": "staff"
  },
  {"key": "is_active", "type": "boolean", "required": true, "default": true},
  {"key": "created_at", "type": "datetime", "required": true},
  {"key": "updated_at", "type": "datetime", "required": true}
];

// Service model attributes
const serviceAttributes = [
  {"key": "name", "type": "string", "size": 255, "required": true},
  {"key": "description", "type": "string", "size": 1000, "required": true},
  {"key": "price", "type": "double", "required": true},
  {"key": "duration", "type": "int", "required": true},
  {"key": "staff_id", "type": "string", "size": 100, "required": true},
  {"key": "created_at", "type": "datetime", "required": true},
  {"key": "updated_at", "type": "datetime", "required": true}
];

// Reservation model attributes
const reservationAttributes = [
  {"key": "service_id", "type": "string", "size": 100, "required": true},
  {"key": "admin_id", "type": "string", "size": 100, "required": true},
  {"key": "customer_name", "type": "string", "size": 255, "required": true},
  {"key": "customer_phone", "type": "string", "size": 20, "required": true},
  {"key": "customer_email", "type": "string", "size": 255, "required": true},
  {"key": "reservation_date", "type": "datetime", "required": true},
  {
    "key": "status",
    "type": "string",
    "size": 50,
    "required": true,
    "default": "pending"
  },
  {"key": "notes", "type": "string", "size": 1000, "required": false},
  {"key": "total_price", "type": "double", "required": true},
  {"key": "created_at", "type": "datetime", "required": true},
  {"key": "updated_at", "type": "datetime", "required": true}
];

// Payment model attributes
const paymentAttributes = [
  {"key": "reservation_id", "type": "string", "size": 100, "required": true},
  {"key": "amount", "type": "double", "required": true},
  {
    "key": "payment_method",
    "type": "string",
    "size": 50,
    "required": true,
    "default": "cash"
  },
  {
    "key": "status",
    "type": "string",
    "size": 50,
    "required": true,
    "default": "unpaid"
  },
  {"key": "transaction_id", "type": "string", "size": 100, "required": false},
  {"key": "notes", "type": "string", "size": 500, "required": false},
  {"key": "paid_at", "type": "datetime", "required": false},
  {"key": "created_at", "type": "datetime", "required": true},
  {"key": "updated_at", "type": "datetime", "required": true}
];
