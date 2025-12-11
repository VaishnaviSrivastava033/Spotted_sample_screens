class MessageTemplate {
  final String id;
  final String name;
  final String type;
  final String status;
  final DateTime createdAt;
  final DateTime? lastUsed;

  MessageTemplate({
    required this.id,
    required this.name,
    required this.type,
    required this.status,
    required this.createdAt,
    this.lastUsed,
  });
}