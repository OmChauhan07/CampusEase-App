import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final String currentScreen;
  
  const AppDrawer({super.key, required this.currentScreen});
  
  @override
  Widget build(BuildContext context) {
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
                CircleAvatar(radius: 50, backgroundColor: Colors.grey[300]),
                const SizedBox(height: 10),
                const Text(
                  'Joe Doe',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          
          // Navigation items
          _buildNavItem(
            context: context,
            title: 'Profile',
            route: '/profile',
            isCurrentScreen: currentScreen == 'profile',
          ),
          _buildNavItem(
            context: context,
            title: 'Reports',
            route: '/reports',
            isCurrentScreen: currentScreen == 'reports',
          ),
          _buildNavItem(
            context: context,
            title: 'Libraries',
            route: '/documents',
            isCurrentScreen: currentScreen == 'documents',
          ),
          _buildNavItem(
            context: context,
            title: 'Recruits',
            route: '/recruits',
            isCurrentScreen: currentScreen == 'recruits',
          ),
          _buildNavItem(
            context: context,
            title: 'Lost & Found',
            route: '/lost_found',
            isCurrentScreen: currentScreen == 'lost_found',
          ),
          _buildNavItem(
            context: context,
            title: 'Schedule',
            route: '/schedule',
            isCurrentScreen: currentScreen == 'schedule',
          ),
          _buildNavItem(
            context: context,
            title: 'Events',
            route: '/events',
            isCurrentScreen: currentScreen == 'events',
          ),
          _buildNavItem(
            context: context,
            title: 'Course Catalog',
            route: '/courses',
            isCurrentScreen: currentScreen == 'courses',
          ),
          
          // Spacer to push remaining items to the bottom
          const Spacer(),
          
          // Setting option moved to just above About
          _buildNavItem(
            context: context,
            title: 'Setting',
            route: '/settings',
            isCurrentScreen: currentScreen == 'settings',
          ),
          
          // About section at the bottom
          _buildNavItem(
            context: context,
            title: 'About',
            route: '/about',
            isCurrentScreen: currentScreen == 'about',
          ),
          _buildNavItem(
            context: context,
            title: 'Home',
            route: '/',
            isCurrentScreen: currentScreen == 'home',
            useReplacement: true,
          ),
        ],
      ),
    );
  }
  
  Widget _buildNavItem({
    required BuildContext context,
    required String title,
    required String route,
    required bool isCurrentScreen,
    bool useReplacement = false,
  }) {
    return ListTile(
      title: Text(title),
      selected: isCurrentScreen,
      onTap: () {
        Navigator.pop(context); // Close the drawer
        
        if (isCurrentScreen) {
          // Already on this screen, just close drawer
          return;
        }
        
        // Navigate to the selected screen
        if (useReplacement) {
          Navigator.pushReplacementNamed(context, route);
        } else {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }
}