import 'package:flutter/material.dart';
import 'report_post_screen.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        backgroundColor: Colors.lightBlue[300],
        actions: [
          // Add an action button for submitting reports
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReportPostScreen(),
                ),
              );
            },
            tooltip: 'Submit Report',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and filter bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search reports...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    // Show filter options
                  },
                ),
              ],
            ),
          ),
          
          // Status filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: true,
                  onSelected: (bool selected) {},
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Pending'),
                  selected: false,
                  onSelected: (bool selected) {},
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('In Progress'),
                  selected: false,
                  onSelected: (bool selected) {},
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text('Resolved'),
                  selected: false,
                  onSelected: (bool selected) {},
                ),
              ],
            ),
          ),
          
          // Reports list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _getReportTitle(index),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color(0xFF800000),
                              ),
                            ),
                            Chip(
                              label: Text(
                                _getReportStatus(index),
                                style: const TextStyle(fontSize: 12, color: Colors.white),
                              ),
                              backgroundColor: _getStatusColor(index),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Type: ${_getReportType(index)}',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Location: ${_getLocation(index)}',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Reported: ${_getDate(index)}',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Description: Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text('View Details'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue[300],
                              ),
                              child: const Text(
                                'Update',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ReportPostScreen(),
            ),
          );
        },
        backgroundColor: Colors.lightBlue[300],
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: 'Submit New Report',
      ),
    );
  }
  
  String _getReportTitle(int index) {
    List<String> titles = [
      'Broken AC', 'Leaking Pipe', 'Flickering Lights', 'Damaged Door', 
      'Wi-Fi Issues', 'Broken Window', 'Elevator Not Working', 
      'Parking Issue', 'Heating Problem', 'Restroom Maintenance'
    ];
    return titles[index % titles.length];
  }
  
  String _getReportType(int index) {
    List<String> types = [
      'Maintenance', 'Plumbing', 'Electrical', 'Facility', 
      'IT', 'Security', 'Cleaning', 'HVAC'
    ];
    return types[index % types.length];
  }
  
  String _getLocation(int index) {
    return 'Building ${(index % 5) + 1}, Room ${100 + index}';
  }
  
  String _getDate(int index) {
    final now = DateTime.now();
    final date = now.subtract(Duration(days: index * 3));
    return '${date.day}/${date.month}/${date.year}';
  }
  
  String _getReportStatus(int index) {
    List<String> statuses = ['Pending', 'In Progress', 'Resolved', 'Closed'];
    return statuses[index % statuses.length];
  }
  
  Color _getStatusColor(int index) {
    switch (index % 4) {
      case 0: return Colors.orange; // Pending
      case 1: return Colors.blue; // In Progress
      case 2: return Colors.green; // Resolved
      case 3: return Colors.grey; // Closed
      default: return Colors.orange;
    }
  }
}