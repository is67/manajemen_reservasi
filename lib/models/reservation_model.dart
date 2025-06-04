class ReservationModel {
  final String id;
  final String userId;
  final String serviceId;
  final String customerName;
  final DateTime date;
  final String time;
  final String status;
  final DateTime createdAt;

  ReservationModel({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.customerName,
    required this.date,
    required this.time,
    required this.status,
    required this.createdAt,
  });

  factory ReservationModel.fromMap(Map<String, dynamic> map) {
    return ReservationModel(
      id: map['\$id'] ?? '',
      userId: map['userId'],
      serviceId: map['serviceId'],
      customerName: map['customerName'],
      date: DateTime.parse(map['date']),
      time: map['time'],
      status: map['status'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'serviceId': serviceId,
      'customerName': customerName,
      'date': date.toIso8601String(),
      'time': time,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
