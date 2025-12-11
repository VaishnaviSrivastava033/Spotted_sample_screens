class MessageLog {
  final String id;
  final String customerNumber;
  final String templateName;
  final String status;
  final DateTime timestamp;
  final String? errorCode;

  MessageLog({
    required this.id,
    required this.customerNumber,
    required this.templateName,
    required this.status,
    required this.timestamp,
    this.errorCode,
  });
}