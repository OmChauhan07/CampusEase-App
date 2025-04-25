import 'package:flutter/material.dart';

class DocumentPostScreen extends StatefulWidget {
  const DocumentPostScreen({super.key});

  @override
  State<DocumentPostScreen> createState() => _DocumentPostScreenState();
}

class _DocumentPostScreenState extends State<DocumentPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  String _documentType = 'Book';
  String _accessLevel = 'Public';
  
  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _descriptionController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Document'),
        backgroundColor: Colors.lightBlue[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Document Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a document title';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(
                  labelText: 'Author/Publisher',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter author or publisher';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Document Type',
                  border: OutlineInputBorder(),
                ),
                value: _documentType,
                items: [
                  'Book', 
                  'Journal', 
                  'Thesis', 
                  'Research Paper',
                  'Magazine',
                  'Newspaper',
                  'Report',
                  'Other'
                ].map((type) => DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    )).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _documentType = value;
                    });
                  }
                },
              ),
              
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Access Level',
                  border: OutlineInputBorder(),
                ),
                value: _accessLevel,
                items: [
                  'Public', 
                  'Students Only', 
                  'Faculty Only', 
                  'Restricted'
                ].map((level) => DropdownMenuItem(
                      value: level,
                      child: Text(level),
                    )).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _accessLevel = value;
                    });
                  }
                },
              ),
              
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description/Abstract',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                  hintText: 'Provide a brief description or abstract...',
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              TextFormField(
                controller: _tagsController,
                decoration: const InputDecoration(
                  labelText: 'Tags/Keywords',
                  border: OutlineInputBorder(),
                  hintText: 'Separate tags with commas',
                ),
              ),
              
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  // File upload functionality would be implemented here
                },
                icon: const Icon(Icons.upload_file),
                label: const Text('Upload Document File'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                ),
              ),
              
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  // Cover image upload functionality would be implemented here
                },
                icon: const Icon(Icons.image),
                label: const Text('Upload Cover Image'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                ),
              ),
              
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Process the form data
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Document added successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    
                    // Clear the form
                    _titleController.clear();
                    _authorController.clear();
                    _descriptionController.clear();
                    _tagsController.clear();
                    setState(() {
                      _documentType = 'Book';
                      _accessLevel = 'Public';
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue[300],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Add Document',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}