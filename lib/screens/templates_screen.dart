import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Template Model
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

class TemplatesScreen extends StatefulWidget {
  const TemplatesScreen({Key? key}) : super(key: key);

  @override
  State<TemplatesScreen> createState() => _TemplatesScreenState();
}

class _TemplatesScreenState extends State<TemplatesScreen> {
  // Spotted pastel UI theme colors for card background
  final Map<String, Color> pastelColors = {
    "approved": const Color(0xffD9F7BE), // light green
    "pending": const Color(0xffFFF4C2), // light yellow
    "rejected": const Color(0xffFAD4D4), // light red/pink
    "default": const Color(0xffF0F0F0), // light grey/off-white
  };

  // Status indicator colors (darker for contrast on the light cards)
  final Map<String, Color> statusBadgeColors = {
    "approved": Colors.green.shade700,
    "pending": Colors.orange.shade800,
    "rejected": Colors.red.shade700,
    "default": Colors.grey.shade700,
  };

  // Sample data
  final List<MessageTemplate> _templates = [
    MessageTemplate(
      id: 'tpl_001',
      name: 'order_confirmation',
      type: 'text',
      status: 'approved',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      lastUsed: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    MessageTemplate(
      id: 'tpl_002',
      name: 'payment_reminder',
      type: 'text',
      status: 'approved',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      lastUsed: DateTime.now().subtract(const Duration(days: 1)),
    ),
    MessageTemplate(
      id: 'tpl_003',
      name: 'delivery_update',
      type: 'media',
      status: 'pending',
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
    MessageTemplate(
      id: 'tpl_004',
      name: 'promotional_offer',
      type: 'interactive',
      status: 'rejected',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'text':
        return Icons.text_fields;
      case 'media':
        return Icons.image;
      case 'interactive':
        return Icons.touch_app;
      default:
        return Icons.message;
    }
  }

  Color _getStatusBadgeColor(String status) {
    return statusBadgeColors[status] ?? statusBadgeColors["default"]!;
  }

  String _formatRelativeTime(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays == 0 && diff.inHours > 0) return "${diff.inHours}h ago";
    if (diff.inDays == 0) return "${diff.inMinutes}m ago";
    if (diff.inDays < 7) return "${diff.inDays}d ago";
    return DateFormat('dd MMM yyyy').format(date); // Use a cleaner format
  }

  void _showTemplateOptions(MessageTemplate template) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)), // More rounded
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle for grabber
            Container(
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.only(bottom: 10),
            ),
            ListTile(
              leading: const Icon(Icons.visibility, color: Color(0xff6A5AE0)), // Primary color
              title: const Text('View Template', style: TextStyle(fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            if (template.status != 'pending')
              ListTile(
                leading: const Icon(Icons.edit, color: Colors.orange),
                title: const Text('Edit Template', style: TextStyle(fontWeight: FontWeight.w600)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete Template', style: TextStyle(fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(context);
                setState(() => _templates.remove(template));
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Use white background for consistency

      // No AppBar — using Spotted-style clean header
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(
                "Templates",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Stats Card — Spotted gradient style
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                // Matching the primary card's gradient from the dashboard
                gradient: const LinearGradient(
                  colors: [Color(0xff6A5AE0), Color(0xff8F79F3)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black12,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatBox("Total", _templates.length.toString()),
                  _StatBox(
                    "Approved",
                    _templates
                        .where((t) => t.status == 'approved')
                        .length
                        .toString(),
                  ),
                  _StatBox(
                    "Pending",
                    _templates
                        .where((t) => t.status == 'pending')
                        .length
                        .toString(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Template List",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            
            const SizedBox(height: 8),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _templates.length,
                itemBuilder: (context, index) {
                  final template = _templates[index];
                  final cardColor =
                      pastelColors[template.status] ?? pastelColors["default"]!;
                  final statusC = _getStatusBadgeColor(template.status);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
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
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      onTap: () => _showTemplateOptions(template),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Row 1 — icon + name + status badge
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 18,
                                  child: Icon(
                                    _getTypeIcon(template.type),
                                    color: Colors.black87,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    template.name,
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
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    template.status.toUpperCase(),
                                    style: TextStyle(
                                      color: statusC,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),
                            const Divider(height: 1, color: Colors.black12),
                            const SizedBox(height: 12),

                            // Type row
                            Text(
                              "Type: ${template.type.toUpperCase()}",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),

                            const SizedBox(height: 8),

                            // Created / Last used
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Created ${_formatRelativeTime(template.createdAt)}",
                                  style: const TextStyle(
                                      color: Colors.black54, fontSize: 12),
                                ),
                                if (template.lastUsed != null)
                                  Text(
                                    "Last used ${_formatRelativeTime(template.lastUsed!)}",
                                    style: const TextStyle(
                                        color: Colors.black54, fontSize: 12),
                                  ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button with a style similar to the 'Scan QR' button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: const Color(0xffC6FF00), // Vibrant green/yellow from UI
        icon: const Icon(Icons.add, color: Colors.black87),
        label: const Text(
          "New Template",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Rounded corners
        ),
        elevation: 6,
      ),
    );
  }
}

// Extracted StatBox to be consistent with the Spotted style
class _StatBox extends StatelessWidget {
  final String label;
  final String value;

  const _StatBox(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
              fontSize: 26, // Slightly larger
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white70,
            )),
      ],
    );
  }
}