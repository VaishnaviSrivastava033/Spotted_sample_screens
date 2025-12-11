import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Message Log Model
class MessageLog {
  final String id;
  final String customerNumber;
  final String templateName;
  final String status;
  final DateTime timestamp; // <--- CORRECTED: Made 'timestamp' required
  final String? errorCode;

  MessageLog({
    required this.id,
    required this.customerNumber,
    required this.templateName,
    required this.status,
    required this.timestamp, // <--- CORRECTED: Marked as required
    this.errorCode,
  });
}

class MessageLogsScreen extends StatefulWidget {
  const MessageLogsScreen({Key? key}) : super(key: key);

  @override
  State<MessageLogsScreen> createState() => _MessageLogsScreenState();
}

class _MessageLogsScreenState extends State<MessageLogsScreen> {
  String _selectedFilter = 'all';
  final List<String> _filterOptions = [
    'all',
    'sent',
    'delivered',
    'read',
    'failed'
  ];

  // Pastel theme colors inspired by Spotted UI for card background
  final Map<String, Color> pastelColors = {
    "sent": const Color(0xffD7E8FF), // light blue
    "delivered": const Color(0xffFFE8C7), // light orange
    "read": const Color(0xffD9F7BE), // light green
    "failed": const Color(0xffFAD4D4), // light red/pink
    "default": const Color(0xffF0F0F0), // light grey/off-white
  };

  // Status indicator colors (darker for contrast on the light cards)
  final Map<String, Color> statusColors = {
    "sent": Colors.blue.shade700,
    "delivered": Colors.orange.shade800,
    "read": Colors.green.shade700,
    "failed": Colors.red.shade700,
    "default": Colors.grey.shade700,
  };

  final List<MessageLog> _messages = [
    MessageLog(
      id: 'msg_001',
      customerNumber: '+91 98989 89898',
      templateName: 'order_confirmation',
      status: 'delivered',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    MessageLog(
      id: 'msg_002',
      customerNumber: '+91 98765 43210',
      templateName: 'payment_reminder',
      status: 'read',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    MessageLog(
      id: 'msg_003',
      customerNumber: '+91 91234 56789',
      templateName: 'delivery_update',
      status: 'failed',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      errorCode: 'Invalid phone number',
    ),
    MessageLog(
      id: 'msg_004',
      customerNumber: '+91 98888 88888',
      templateName: 'welcome_message',
      status: 'sent',
      timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
  ];

  List<MessageLog> get _filteredMessages {
    if (_selectedFilter == 'all') return _messages;
    return _messages.where((msg) => msg.status == _selectedFilter).toList();
  }

  Color _getStatusColor(String status) {
    return statusColors[status] ?? statusColors["default"]!;
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'sent':
        return Icons.send;
      case 'delivered':
        return Icons.done;
      case 'read':
        return Icons.done_all;
      case 'failed':
        return Icons.error_outline;
      default:
        return Icons.help_outline;
    }
  }

  // Helper method for the Filter Chips to match the "All" button style
  Widget _buildFilterChip(String filter) {
    final isSelected = _selectedFilter == filter;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedFilter = filter);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xff6A5AE0) // Primary Purple from Spotted
              : Colors.white,
          borderRadius: BorderRadius.circular(10), // Reduced rounding
          border: Border.all(
              color: isSelected ? Colors.transparent : Colors.grey.shade200,
              width: 1),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xff6A5AE0).withOpacity(0.3),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ]
              : [],
        ),
        child: Text(
          filter.toUpperCase(),
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // Use white/light background for consistency

      // Custom Header — similar to Spotted’s
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Message Logs",
                    style: TextStyle(
                      fontSize: 28, // Slightly larger
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  // Add a button or icon if needed for consistency, e.g. menu icon
                  const Icon(Icons.menu, color: Colors.black87),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Filter Chips - Replaced ChoiceChip with custom container for style match
            Container(
              padding: const EdgeInsets.only(left: 20),
              height: 40, // Adjusted height for better spacing
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemCount: _filterOptions.length,
                itemBuilder: (context, i) {
                  final filter = _filterOptions[i];
                  return _buildFilterChip(filter);
                },
              ),
            ),

            const SizedBox(height: 20),

            // Message count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "${_filteredMessages.length} messages found",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Message List
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _filteredMessages.length,
                itemBuilder: (context, index) {
                  final message = _filteredMessages[index];
                  final cardColor =
                      pastelColors[message.status] ?? pastelColors["default"]!;
                  final statusC = _getStatusColor(message.status);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(25), // More rounded
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row Top
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 18, // Slightly smaller avatar
                              child: Icon(
                                _getStatusIcon(message.status),
                                color: statusC,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                message.customerNumber,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: statusC.withOpacity(0.15), // Light tint
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                message.status.toUpperCase(),
                                style: TextStyle(
                                  color: statusC,
                                  fontWeight: FontWeight.w700, // Semi-bold
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),
                        const Divider(height: 1, color: Colors.black12),
                        const SizedBox(height: 12),

                        Text(
                          "Template: ${message.templateName}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          DateFormat('MMM dd, yyyy • hh:mm a').format(
                              message.timestamp), // Now guaranteed non-null
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),

                        if (message.errorCode != null) ...[
                          const SizedBox(height: 6),
                          Text(
                            "Error: ${message.errorCode}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red.shade700,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
