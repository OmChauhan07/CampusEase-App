import 'package:flutter/material.dart';
import 'main.dart';
import 'reports_screen.dart';
import 'recruits_screen.dart';
import 'lost_found_screen.dart';
import 'documents_screen.dart';
import 'recruitment_post_screen.dart';
import 'lost_found_post_screen.dart';
import 'report_post_screen.dart';
import 'document_post_screen.dart';
import 'events_screen.dart';
import 'event_post_screen.dart';
import 'schedule_screen.dart';
import 'course_catalog_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (context) => const HomePage(),
      '/reports': (context) => const ReportsScreen(),
      '/recruits': (context) => const RecruitsScreen(),
      '/lost_found': (context) => const LostFoundScreen(),
      '/documents': (context) => const DocumentsScreen(),
      '/events': (context) => const EventsScreen(),
      '/schedule': (context) => const ScheduleScreen(),
      '/courses': (context) => const CourseCatalogScreen(),
      '/recruitment_post': (context) => const RecruitmentPostScreen(),
      '/lost_found_post': (context) => const LostFoundPostScreen(),
      '/report_post': (context) => const ReportPostScreen(),
      '/document_post': (context) => const DocumentPostScreen(),
      '/event_post': (context) => const EventPostScreen(),
    };
  }
}