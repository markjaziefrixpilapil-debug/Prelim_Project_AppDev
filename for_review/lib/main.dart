import 'package:flutter/material.dart';

import 'screens/dashboard_screen.dart';
import 'screens/profile_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.indigo.shade50,
      ),
      home: const DashboardScreen(),
      routes: {
        '/expenses': (context) => const ExpensesPage(),
        '/profiles': (context) => const ProfileListPage(),
      },
    );
  }
}
