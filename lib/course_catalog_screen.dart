import 'package:flutter/material.dart';

import 'app_drawer.dart';

class CourseCatalogScreen extends StatefulWidget {
  const CourseCatalogScreen({super.key});

  @override
  State<CourseCatalogScreen> createState() => _CourseCatalogScreenState();
}

class _CourseCatalogScreenState extends State<CourseCatalogScreen> with SingleTickerProviderStateMixin {
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
      drawer: const AppDrawer(currentScreen: 'courses'),
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[300],
        title: const Text(
          'Course Catalog',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and subtitle
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Course Catalog',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Browse and register for available courses',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          // Tab bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.blue[700],
              unselectedLabelColor: Colors.grey[600],
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              tabs: const [
                Tab(text: 'All Courses'),
                Tab(text: 'My Courses'),
                Tab(text: 'Available'),
                Tab(text: 'Upcoming'),
              ],
            ),
          ),
          
          // Course list
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCourseList(),
                _buildCourseList(onlyMyCourses: true),
                _buildCourseList(onlyAvailable: true),
                _buildCourseList(onlyUpcoming: true),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCourseList({
    bool onlyMyCourses = false,
    bool onlyAvailable = false,
    bool onlyUpcoming = false,
  }) {
    // Sample course data
    final courses = [
      {
        'title': 'Introduction to Computer Science',
        'code': 'CS101',
        'credits': 3,
        'instructor': 'Dr. Sarah Johnson',
        'schedule': 'Mon, Wed, Fri 10:00 AM - 11:30 AM',
        'enrollment': '42/50 Students',
        'description': 'An introduction to the fundamentals of computer science, including problem-solving, programming basics, algorithms, and data structures.',
        'isEnrolled': true,
        'isAvailable': true,
        'isUpcoming': false,
      },
      {
        'title': 'Linear Algebra',
        'code': 'MATH204',
        'credits': 4,
        'instructor': 'Prof. Michael Chen',
        'schedule': 'Tue, Thu 1:00 PM - 2:30 PM',
        'enrollment': '35/40 Students',
        'description': 'Study of vector spaces, linear transformations, matrices, and systems of linear equations with applications in various fields.',
        'isEnrolled': false,
        'isAvailable': true,
        'isUpcoming': false,
      },
      {
        'title': 'Human Physiology',
        'code': 'BIO220',
        'credits': 4,
        'instructor': 'Dr. Emily Rodriguez',
        'schedule': 'Mon, Wed 2:00 PM - 3:30 PM',
        'enrollment': '38/45 Students',
        'description': 'An exploration of human body systems, their functions, and mechanisms of maintaining homeostasis.',
        'isEnrolled': false,
        'isAvailable': true,
        'isUpcoming': false,
      },
      {
        'title': 'Organic Chemistry',
        'code': 'CHEM301',
        'credits': 4,
        'instructor': 'Dr. James Wilson',
        'schedule': 'Tue, Thu 10:00 AM - 11:30 AM',
        'enrollment': '28/30 Students',
        'description': 'Study of carbon compounds, their properties, reactions, and synthesis with applications in medicine and materials science.',
        'isEnrolled': false,
        'isAvailable': true,
        'isUpcoming': false,
      },
      {
        'title': 'World History',
        'code': 'HIST101',
        'credits': 3,
        'instructor': 'Prof. Amanda Lee',
        'schedule': 'Mon, Wed, Fri 1:00 PM - 2:00 PM',
        'enrollment': '45/60 Students',
        'description': 'Survey of major historical events and developments from ancient civilizations to the modern era.',
        'isEnrolled': true,
        'isAvailable': true,
        'isUpcoming': false,
      },
      {
        'title': 'Advanced Machine Learning',
        'code': 'CS440',
        'credits': 4,
        'instructor': 'Dr. Robert Zhang',
        'schedule': 'Starting Fall 2024',
        'enrollment': '0/30 Students',
        'description': 'Advanced techniques in machine learning including deep learning, reinforcement learning, and natural language processing.',
        'isEnrolled': false,
        'isAvailable': false,
        'isUpcoming': true,
      },
    ];
    
    // Filter courses based on tab
    final filteredCourses = courses.where((course) {
      if (onlyMyCourses) return course['isEnrolled'] as bool;
      if (onlyAvailable) return course['isAvailable'] as bool;
      if (onlyUpcoming) return course['isUpcoming'] as bool;
      return true;
    }).toList();
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredCourses.length,
      itemBuilder: (context, index) {
        final course = filteredCourses[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course header with title and credits
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        course['title'] as String,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '${course['credits']} Credits',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Course code
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Text(
                  course['code'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
              ),
              
              // Instructor
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Row(
                  children: [
                    Icon(Icons.person, size: 18, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(
                      'Instructor',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      course['instructor'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Schedule
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Row(
                  children: [
                    Icon(Icons.schedule, size: 18, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(
                      'Schedule',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      course['schedule'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Enrollment
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Row(
                  children: [
                    Icon(Icons.group, size: 18, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Text(
                      'Enrollment',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      course['enrollment'] as String,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Description
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Text(
                  course['description'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              
              // Action buttons
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.blue[400]!),
                        ),
                        child: const Text('View Details'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: course['isEnrolled'] as bool ? null : () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[400],
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Colors.grey[300],
                          disabledForegroundColor: Colors.grey[600],
                        ),
                        child: Text(course['isEnrolled'] as bool ? 'Enrolled' : 'Enroll'),
                      ),
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
            title: const Text('Schedule'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/schedule');
            },
          ),
          ListTile(
            title: const Text('Course Catalog'),
            onTap: () {
              Navigator.pop(context);
              // Already on course catalog page
            },
          ),
          ListTile(
            title: const Text('Events'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/events');
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