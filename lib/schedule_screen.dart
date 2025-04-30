import 'package:flutter/material.dart';
import 'app_drawer.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  String _selectedSemester = 'Spring 2025';
  String _selectedDepartment = 'IT Department';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(currentScreen: 'schedule'),
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[300],
        title: const Text(
          'Class Schedule',
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
                  'Class Schedule',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Weekly class timetable for $_selectedDepartment',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          // Semester and Department selectors
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Semester dropdown
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedSemester,
                        isExpanded: true,
                        hint: const Text('Semester'),
                        items: const [
                          DropdownMenuItem(
                            value: 'Spring 2025',
                            child: Text('Spring 2025'),
                          ),
                          DropdownMenuItem(
                            value: 'Fall 2024',
                            child: Text('Fall 2024'),
                          ),
                          DropdownMenuItem(
                            value: 'Summer 2024',
                            child: Text('Summer 2024'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedSemester = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Department dropdown
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedDepartment,
                        isExpanded: true,
                        hint: const Text('Department'),
                        items: const [
                          DropdownMenuItem(
                            value: 'IT Department',
                            child: Text('IT Department'),
                          ),
                          DropdownMenuItem(
                            value: 'Business',
                            child: Text('Business'),
                          ),
                          DropdownMenuItem(
                            value: 'Engineering',
                            child: Text('Engineering'),
                          ),
                          DropdownMenuItem(
                            value: 'Arts & Sciences',
                            child: Text('Arts & Sciences'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedDepartment = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Schedule table
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Table header
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[600],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          _buildHeaderCell('Time/Day', flex: 2),
                          _buildHeaderCell('Monday'),
                          _buildHeaderCell('Tuesday'),
                          _buildHeaderCell('Wednesday'),
                          _buildHeaderCell('Thursday'),
                          _buildHeaderCell('Friday'),
                        ],
                      ),
                    ),

                    // Updated time slots based on the image
                    _buildTimeSlotRow('08:00 AM to 09:00 AM', [
                      _buildClassCell('ITCS01', 'Room 123'),
                      _buildClassCell('ITCS02', 'Room 124'),
                      _buildClassCell('ITCS03', 'Room 125'),
                      _buildClassCell('ITCS04', 'Room 126'),
                      _buildClassCell('ITCS05', 'Room 127'),
                    ]),

                    _buildTimeSlotRow('09:00 AM to 10:00 AM', [
                      _buildClassCell('ITCS06', 'Room 128'),
                      _buildClassCell('ITCS07', 'Room 129'),
                      _buildClassCell('ITCS08', 'Room 130'),
                      _buildClassCell('ITCS09', 'Room 131'),
                      _buildClassCell('ITCS10', 'Room 132'),
                    ]),

                    _buildTimeSlotRow('10:00 AM to 11:00 AM', [
                      _buildClassCell('ITCS11', 'Room 133'),
                      _buildClassCell('ITCS12', 'Room 134'),
                      _buildClassCell('ITCS13', 'Room 135'),
                      _buildClassCell('ITCS14', 'Room 136'),
                      _buildClassCell('ITCS15', 'Room 137'),
                    ]),

                    _buildTimeSlotRow('11:00 AM to 12:00 PM', [
                      _buildClassCell('ITCS16', 'Room 138'),
                      _buildClassCell('ITCS17', 'Room 139'),
                      _buildClassCell('ITCS18', 'Room 140'),
                      _buildClassCell('ITCS19', 'Room 141'),
                      _buildClassCell('ITCS20', 'Room 142'),
                    ]),

                    _buildTimeSlotRow('12:00 PM to 01:00 PM', [
                      Container(),
                      Container(),
                      Container(),
                      Container(),
                      Container(),
                    ], isBreak: true),

                    _buildTimeSlotRow('01:00 PM to 02:00 PM', [
                      _buildClassCell('ITCS21', 'Room 143'),
                      _buildClassCell('ITCS22', 'Room 144'),
                      _buildClassCell('ITCS23', 'Room 145'),
                      _buildClassCell('ITCS24', 'Room 146'),
                      _buildClassCell('ITCS25', 'Room 147'),
                    ]),

                    _buildTimeSlotRow('02:00 PM to 03:00 PM', [
                      _buildClassCell('ITCS26', 'Room 148'),
                      _buildClassCell('ITCS27', 'Room 149'),
                      _buildClassCell('ITCS28', 'Room 150'),
                      _buildClassCell('ITCS29', 'Room 151'),
                      _buildClassCell('ITCS30', 'Room 152'),
                    ]),

                    _buildTimeSlotRow('03:00 PM to 04:00 PM', [
                      _buildClassCell('ITCS31', 'Room 153'),
                      _buildClassCell('ITCS32', 'Room 154'),
                      _buildClassCell('ITCS33', 'Room 155'),
                      _buildClassCell('ITCS34', 'Room 156'),
                      _buildClassCell('ITCS35', 'Room 157'),
                    ]),

                    _buildTimeSlotRow('04:00 PM to 05:00 PM', [
                      _buildClassCell('ITCS36', 'Room 158'),
                      _buildClassCell('ITCS37', 'Room 159'),
                      _buildClassCell('ITCS38', 'Room 160'),
                      _buildClassCell('ITCS39', 'Room 161'),
                      _buildClassCell('ITCS40', 'Room 162'),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildTimeSlotRow(
    String timeText,
    List<Widget> dayCells, {
    bool isBreak = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isBreak ? Colors.grey[200] : Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!),
          left: BorderSide(color: Colors.grey[300]!),
          right: BorderSide(color: Colors.grey[300]!),
        ),
      ),
      child: Row(
        children: [
          // Time column
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              height:
                  isBreak
                      ? 40
                      : (dayCells.any((cell) => cell is MultiClassCell)
                          ? 120
                          : 80),
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.grey[300]!)),
                color: Colors.grey[100],
              ),
              child: Text(
                timeText,
                style: TextStyle(
                  fontWeight: isBreak ? FontWeight.bold : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Day cells
          ...dayCells.map((cell) => Expanded(child: cell)).toList(),
        ],
      ),
    );
  }

  Widget _buildClassCell(String courseCode, String roomInfo) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            courseCode,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            roomInfo,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildMultiClassCell(List<ClassInfo> classes) {
    return MultiClassCell(classes: classes);
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
              // Already on schedule page, just close drawer
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

// Helper class for multi-class cells
class MultiClassCell extends StatelessWidget {
  final List<ClassInfo> classes;

  const MultiClassCell({super.key, required this.classes});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            classes.map((classInfo) => _buildClassItem(classInfo)).toList(),
      ),
    );
  }

  Widget _buildClassItem(ClassInfo classInfo) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  classInfo.courseCode,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  classInfo.roomInfo,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Helper class to store class information
class ClassInfo {
  final String courseCode;
  final String roomInfo;

  ClassInfo(this.courseCode, this.roomInfo);
}
