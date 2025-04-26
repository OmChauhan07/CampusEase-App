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

  // List of available documents
  final List<Document> _availableDocuments = [
    Document(
      title: 'Introduction to Computer Science',
      author: 'Dr. James Smith',
      type: 'Textbook',
      description: 'A comprehensive introduction to computer science principles and programming fundamentals.',
      tags: ['Computer Science', 'Programming', 'Beginner'],
      coverImage: 'assets/images/cs_book.jpg',
    ),
    Document(
      title: 'Advanced Calculus',
      author: 'Prof. Maria Rodriguez',
      type: 'Textbook',
      description: 'In-depth exploration of advanced calculus concepts including multivariable calculus and differential equations.',
      tags: ['Mathematics', 'Calculus', 'Advanced'],
      coverImage: 'assets/images/math_book.jpg',
    ),
    Document(
      title: 'Quantum Physics Research Paper',
      author: 'Dr. Robert Chen',
      type: 'Research Paper',
      description: 'Recent findings in quantum entanglement and its applications in quantum computing.',
      tags: ['Physics', 'Quantum', 'Research'],
      coverImage: 'assets/images/physics_paper.jpg',
    ),
    Document(
      title: 'Campus Sustainability Report 2023',
      author: 'Environmental Committee',
      type: 'Report',
      description: 'Annual report on campus sustainability initiatives, achievements, and future goals.',
      tags: ['Environment', 'Sustainability', 'Report'],
      coverImage: 'assets/images/sustainability.jpg',
    ),
  ];

  bool _showRequests = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context),
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[300],
        title: Text(
          _showRequests ? 'Document Requests' : 'Library Documents',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // Toggle between documents and requests
          IconButton(
            icon: Icon(_showRequests ? Icons.book : Icons.request_page),
            onPressed: () {
              setState(() {
                _showRequests = !_showRequests;
              });
            },
            tooltip: _showRequests ? 'View Documents' : 'View Requests',
          ),
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
      body: _showRequests ? _buildRequestsView() : _buildDocumentsView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_showRequests) {
            _showNewDocumentRequestForm(context);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DocumentPostScreen(),
              ),
            );
          }
        },
        backgroundColor: Colors.lightBlue[300],
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: 'Add New Document',
      ),
    );
  }

  Widget _buildDocumentsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search documents...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
        ),
        
        // Document categories
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              _buildCategoryChip('All', true),
              _buildCategoryChip('Textbooks', false),
              _buildCategoryChip('Research Papers', false),
              _buildCategoryChip('Journals', false),
              _buildCategoryChip('Reports', false),
              _buildCategoryChip('Magazines', false),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Documents list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: _availableDocuments.length,
            itemBuilder: (context, index) {
              final document = _availableDocuments[index];
              return _buildDocumentCard(document);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(label),
        backgroundColor: isSelected ? Colors.lightBlue[300] : Colors.grey[200],
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  Widget _buildDocumentCard(Document document) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Document type header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: _getTypeColor(document.type),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  _getTypeIcon(document.type),
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  document.type,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Document content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Document cover image
                Container(
                  width: 80,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: AssetImage(document.coverImage),
                      fit: BoxFit.cover,
                      onError: (_, __) {},
                    ),
                  ),
                  child: document.coverImage.isEmpty
                      ? Icon(
                          _getTypeIcon(document.type),
                          size: 40,
                          color: Colors.grey[600],
                        )
                      : null,
                ),
                
                const SizedBox(width: 16),
                
                // Document details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        document.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'By ${document.author}',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        document.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: document.tags.map((tag) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[800],
                            ),
                          ),
                        )).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Action buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download),
                  label: const Text('Download'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.lightBlue[700],
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility),
                  label: const Text('View'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[300],
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'Textbook':
        return Colors.blue[300]!;
      case 'Research Paper':
        return Colors.purple[300]!;
      case 'Journal':
        return Colors.green[300]!;
      case 'Report':
        return Colors.orange[300]!;
      case 'Magazine':
        return Colors.red[300]!;
      default:
        return Colors.grey[400]!;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'Textbook':
        return Icons.book;
      case 'Research Paper':
        return Icons.science;
      case 'Journal':
        return Icons.article;
      case 'Report':
        return Icons.assessment;
      case 'Magazine':
        return Icons.menu_book;
      default:
        return Icons.description;
    }
  }

  Widget _buildRequestsView() {
    return ListView(
      children: _documentRequests.map((doc) => _buildDocumentRequestCard(
        doc.title,
        doc.department,
        doc.location,
        doc.status,
      )).toList(),
    );
  }

  Widget _buildDocumentRequestCard(String title, String department, String location, String status) {
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
              Navigator.pushNamed(context, '/reports');
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
              Navigator.pushNamed(context, '/recruits');
            },
          ),
          ListTile(
            title: const Text('Lost & Found'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/lost_found');
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
}

// Document request class
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

// Document class
class Document {
  final String title;
  final String author;
  final String type;
  final String description;
  final List<String> tags;
  final String coverImage;

  Document({
    required this.title,
    required this.author,
    required this.type,
    required this.description,
    required this.tags,
    this.coverImage = '',
  });
}
