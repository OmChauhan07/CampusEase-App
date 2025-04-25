import 'package:flutter/material.dart';
import 'document_post_screen.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  // List of document requests
  final List<DocumentRequest> _documentRequests = [
    DocumentRequest(
      title: 'Transcript',
      department: 'Registrar Office',
      location: 'Admin Building, Room 101',
      status: 'Processing',
    ),
    DocumentRequest(
      title: 'Degree Certificate',
      department: 'Academic Affairs',
      location: 'Admin Building, Room 205',
      status: 'Ready',
    ),
    DocumentRequest(
      title: 'Recommendation Letter',
      department: 'Computer Science',
      location: 'Science Building, Room 302',
      status: 'Completed',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[300],
        title: const Text(
          'Document Requests',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // Add document button in app bar
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DocumentPostScreen(),
                ),
              );
            },
            tooltip: 'Add Document',
          ),
        ],
      ),
      body: ListView(
        children: _documentRequests.map((doc) => _buildDocumentCard(
          doc.title,
          doc.department,
          doc.location,
          doc.status,
        )).toList(),
      ),
      // Add floating action button for quick access
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNewDocumentRequestForm(context);
        },
        backgroundColor: Colors.lightBlue[300],
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: 'Add New Document',
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // User profile header
          Container(
            color: Colors.lightBlue[300],
            padding: const EdgeInsets.symmetric(vertical: 40),
            width: double.infinity,
            child: Column(
              children: [
                // Profile image
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Joe Doe',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Navigation items
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to profile page
            },
          ),
          ListTile(
            title: const Text('Reports'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/reports');
            },
          ),
          ListTile(
            title: const Text('Libraries'),
            onTap: () {
              Navigator.pop(context);
              // Already on documents page, just close drawer
            },
          ),
          ListTile(
            title: const Text('Recruits'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/recruits');
            },
          ),
          ListTile(
            title: const Text('Lost & Found'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/lost_found');
            },
          ),
          ListTile(
            title: const Text('Setting'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to settings page
            },
          ),
          
          // Spacer to push "About" to the bottom
          const Spacer(),
          
          // About section at the bottom
          ListTile(
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              // Navigate to about page
            },
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(String title, String department, String location, String status) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Green part (image placeholder)
          Container(
            width: 120,
            decoration: const BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.description,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
          
          // Gray part (document details)
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFFE0E0E0),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(department),
                  const SizedBox(height: 4),
                  Text(location),
                  const SizedBox(height: 4),
                  Text(
                    'Status: $status',
                    style: TextStyle(
                      color: _getStatusColor(status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Processing':
        return Colors.orange;
      case 'Ready':
        return Colors.green;
      case 'Completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  void _showNewDocumentRequestForm(BuildContext context) {
    final titleController = TextEditingController();
    final departmentController = TextEditingController();
    final locationController = TextEditingController();
    final descriptionController = TextEditingController();
    String selectedDocType = 'Transcript';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('Request Document'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Document type dropdown
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Document Type',
                    ),
                    value: selectedDocType,
                    items: const [
                      DropdownMenuItem(value: 'Transcript', child: Text('Transcript')),
                      DropdownMenuItem(value: 'Degree Certificate', child: Text('Degree Certificate')),
                      DropdownMenuItem(value: 'Recommendation Letter', child: Text('Recommendation Letter')),
                      DropdownMenuItem(value: 'Other', child: Text('Other')),
                    ],
                    onChanged: (value) {
                      setDialogState(() {
                        selectedDocType = value!;
                        if (value != 'Other') {
                          titleController.text = value;
                        } else {
                          titleController.text = '';
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  if (selectedDocType == 'Other')
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Document Title'),
                    ),
                  TextField(
                    controller: departmentController,
                    decoration: const InputDecoration(labelText: 'Department'),
                  ),
                  TextField(
                    controller: locationController,
                    decoration: const InputDecoration(labelText: 'Office Location'),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Additional Details'),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Validate and submit
                  if ((selectedDocType != 'Other' || titleController.text.isNotEmpty) &&
                      departmentController.text.isNotEmpty &&
                      locationController.text.isNotEmpty) {
                    // Add the new document request to the list
                    final title = selectedDocType == 'Other' ? titleController.text : selectedDocType;
                    
                    // Update state with new document request
                    setState(() {
                      _documentRequests.add(
                        DocumentRequest(
                          title: title,
                          department: departmentController.text,
                          location: locationController.text,
                          status: 'Processing',
                        ),
                      );
                    });
                    
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Document request submitted successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill all required fields'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Create a class to represent a document request
class DocumentRequest {
  final String title;
  final String department;
  final String location;
  final String status;

  DocumentRequest({
    required this.title,
    required this.department,
    required this.location,
    required this.status,
  });
}
