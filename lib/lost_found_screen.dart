import 'package:flutter/material.dart';
import 'lost_found_post_screen.dart';
import 'app_drawer.dart';

class LostFoundScreen extends StatefulWidget {
  const LostFoundScreen({super.key});

  @override
  State<LostFoundScreen> createState() => _LostFoundScreenState();
}

class _LostFoundScreenState extends State<LostFoundScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(currentScreen: 'lost_found'),
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[300],
        title: const Text(
          'Lost & Found',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Lost Items'),
            Tab(text: 'Found Items'),
          ],
        ),
        actions: [
          // Add an action button for posting lost & found items
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LostFoundPostScreen(),
                ),
              );
            },
            tooltip: 'Post Lost & Found Item',
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Lost Items Tab
          _buildItemsList(isLost: true),
          
          // Found Items Tab
          _buildItemsList(isLost: false),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LostFoundPostScreen(),
            ),
          );
        },
        backgroundColor: Colors.lightBlue[300],
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: 'Post New Item',
      ),
    );
  }
}
  
Widget _buildItemsList({required bool isLost}) {
  return ListView.builder(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Item image placeholder
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.image, size: 40, color: Colors.grey),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isLost ? 'Lost ${_getItemName(index)}' : 'Found ${_getItemName(index)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFF800000),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Category: ${_getCategory(index)}',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Location: ${_getLocation(index)}',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Date: ${_getDate(index)}',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                ],
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
                    child: const Text('Contact'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue[300],
                    ),
                    child: Text(
                      isLost ? 'I Found It' : 'Claim Item',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
  
String _getItemName(int index) {
  List<String> items = [
    'Laptop', 'Phone', 'Wallet', 'Keys', 'Backpack', 
    'Textbook', 'Water Bottle', 'ID Card', 'Glasses', 'Umbrella'
  ];
  return items[index % items.length];
}
  
String _getCategory(int index) {
  List<String> categories = [
    'Electronics', 'Accessories', 'Books', 'Clothing', 'ID/Cards'
  ];
  return categories[index % categories.length];
}
  
String _getLocation(int index) {
  List<String> locations = [
    'Library', 'Cafeteria', 'Lecture Hall A', 'Computer Lab', 'Student Center',
    'Gym', 'Dormitory', 'Admin Building', 'Parking Lot', 'Bus Stop'
  ];
  return locations[index % locations.length];
}
  
String _getDate(int index) {
  final now = DateTime.now();
  final date = now.subtract(Duration(days: index * 2));
  return '${date.day}/${date.month}/${date.year}';
}
  
// Add this method to your _LostFoundScreenState class
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
            Navigator.pushNamed(context, '/documents');
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
            // Already on lost & found page, just close drawer
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