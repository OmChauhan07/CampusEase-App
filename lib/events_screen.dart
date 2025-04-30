import 'package:flutter/material.dart';
import 'event_post_screen.dart';
import 'app_drawer.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(currentScreen: 'events'),
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[300],
        title: const Text(
          'Campus Events',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(text: 'All Events'),
            Tab(text: 'Academic'),
            Tab(text: 'Social'),
            Tab(text: 'Career'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search events...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          
          // Events list
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // All Events Tab
                _buildEventsList(eventType: 'all'),
                
                // Academic Events Tab
                _buildEventsList(eventType: 'academic'),
                
                // Social Events Tab
                _buildEventsList(eventType: 'social'),
                
                // Career Events Tab
                _buildEventsList(eventType: 'career'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/event_post');
        },
        backgroundColor: Colors.lightBlue[300],
        child: const Icon(Icons.add, color: Colors.white),
        tooltip: 'Post New Event',
      ),
    );
  }
  
  Widget _buildEventsList({required String eventType}) {
    // Filter events based on eventType if needed
    final List<Map<String, dynamic>> events = _getEvents(eventType);
    
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Event image
              Stack(
                children: [
                  // Using a placeholder container instead of Image.asset
                  Container(
                    height: 150,
                    width: double.infinity,
                    color: _getCategoryColor(event['category'] as String).withOpacity(0.3),
                    child: Icon(
                      Icons.event,
                      size: 50,
                      color: _getCategoryColor(event['category'] as String),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Chip(
                      label: Text(
                        event['category'] as String,
                        style: const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      backgroundColor: _getCategoryColor(event['category'] as String),
                    ),
                  ),
                ],
              ),
              
              // Event details
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event['title'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          event['date'] as String,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          event['time'] as String,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          event['location'] as String,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.people, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          '${event['attending']} attending',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      event['description'] as String,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
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
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  List<Map<String, dynamic>> _getEvents(String eventType) {
    // Sample events data
    final List<Map<String, dynamic>> allEvents = [
      {
        'title': 'Fall Welcome Festival',
        'date': 'September 5, 2023',
        'time': '4:00 PM - 8:00 PM',
        'location': 'Main Quad',
        'category': 'social',
        'attending': 230,
        'description': 'Kick off the new academic year with food, music, games, and connect with campus organizations.',
      },
      {
        'title': 'Career Fair: Tech & Engineering',
        'date': 'October 12, 2023',
        'time': '10:00 AM - 3:00 PM',
        'location': 'Student Union Ballroom',
        'category': 'career',
        'attending': 185,
        'description': 'Meet recruiters from leading technology and engineering companies. Bring your resume!',
      },
      {
        'title': 'Guest Lecture: Artificial Intelligence Ethics',
        'date': 'October 20, 2023',
        'time': '5:00 PM - 7:00 PM',
        'location': 'Science Building, Room 101',
        'category': 'academic',
        'attending': 120,
        'description': 'Distinguished speaker Dr. Maya Patel discusses the ethical implications of AI development.',
      },
      {
        'title': 'Student Research Symposium',
        'date': 'November 15, 2023',
        'time': '1:00 PM - 5:00 PM',
        'location': 'University Center',
        'category': 'academic',
        'attending': 95,
        'description': 'Undergraduate and graduate students present their research projects across all disciplines.',
      },
      {
        'title': 'Campus Movie Night',
        'date': 'September 18, 2023',
        'time': '8:00 PM - 10:30 PM',
        'location': 'Outdoor Amphitheater',
        'category': 'social',
        'attending': 210,
        'description': 'Join us for an outdoor screening of the latest blockbuster. Free popcorn and drinks provided!',
      },
    ];
    
    // Filter events based on type
    if (eventType == 'all') {
      return allEvents;
    } else {
      return allEvents.where((event) => event['category'] == eventType).toList();
    }
  }
  
  Color _getCategoryColor(String category) {
    switch (category) {
      case 'academic':
        return Colors.green;
      case 'social':
        return Colors.purple;
      case 'career':
        return Colors.orange;
      default:
        return Colors.blue;
    }
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
            title: const Text('Events'),
            onTap: () {
              Navigator.pop(context);
              // Already on events page, just close drawer
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