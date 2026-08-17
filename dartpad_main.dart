import 'dart:convert';

import 'package:flutter/material.dart';

void main() {
  runApp(const StudentDashboardApp());
}

class StudentDashboardApp extends StatelessWidget {
  const StudentDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Expense Dashboard',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

final Map<String, Map<String, dynamic>> monthlyExpenses = {
  'July': {
    'allowance': 3200,
    'expenses': {
      'Chicken Joo': 350,
      'Mineral Water': 280,
      'Ballpoint Pen': 90,
      'Train Fare': 280,
      'Public Transport': 900,
    },
  },
  'August': {
    'allowance': 3500,
    'expenses': {
      'Chicken Joo': 400,
      'Mineral Water': 300,
      'Ballpoint Pen': 100,
      'Train Fare': 300,
      'Public Transport': 1000,
    },
  },
  'September': {
    'allowance': 3600,
    'expenses': {
      'Chicken Joo': 420,
      'Mineral Water': 320,
      'Ballpoint Pen': 110,
      'Train Fare': 310,
      'Public Transport': 1050,
    },
  },
};

final List<Map<String, dynamic>> students = [
  {
    'name': 'Justin R. Baby',
    'imageKey': 'first_member',
    'course': 'BS Computer Science',
    'email': 'justin.baby@example.com',
    'phone': '+63 912 345 6789',
    'address': '123 Sampaguita St., Central, Quezon City',
    'expenses': {
      'Food': 600,
      'Transport': 300,
      'Supplies': 150,
      'Internet': 800,
      'Printing': 120,
      'Snacks': 200,
      'Coffee': 180,
      'Tuition and Miscellaneous': 500,
      'Phone Load': 250,
      'Laundry': 200,
    },
  },
  {
    'name': 'Frix Pilapil',
    'imageKey': 'second_member',
    'course': 'BS Information Technology',
    'email': 'frix.pilapil@gmail.com',
    'phone': '+63 951 6845 135',
    'address': '35 E Main St., Sta. Lucia, Pasig City',
    'expenses': {
      'Food': 700,
      'Transport': 350,
      'Supplies': 120,
      'Internet': 900,
      'Printing': 100,
      'Snacks': 220,
      'Coffee': 150,
      'Tuition and Miscellaneous': 400,
      'Phone Load': 300,
      'Laundry': 180,
    },
  },
  {
    'name': 'Dayer V. Aniog',
    'imageKey': 'third_member',
    'course': 'BS Yearning',
    'email': 'dayer.aniog@example.com',
    'phone': '+63 918 333 4444',
    'address': '88 Mayon St., Manggahan, Pasig City',
    'expenses': {
      'Food': 650,
      'Transport': 320,
      'Supplies': 130,
      'Internet': 700,
      'Printing': 110,
      'Snacks': 210,
      'Coffee': 140,
      'Tuition and Miscellaneous': 450,
      'Phone Load': 260,
      'Laundry': 190,
    },
  },
  {
    'name': 'Angelo M. Victorino',
    'imageKey': 'fourth_member',
    'course': 'BS Nursing',
    'email': 'angelo.victorino@example.com',
    'phone': '+63 919 555 6666',
    'address': '200 Clark Rd., Cutud, Quezon City',
    'expenses': {
      'Food': 720,
      'Transport': 340,
      'Supplies': 160,
      'Internet': 850,
      'Printing': 130,
      'Snacks': 230,
      'Coffee': 170,
      'Tuition and Miscellaneous': 480,
      'Phone Load': 280,
      'Laundry': 210,
    },
  },
];

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedMonth = 'July';

  @override
  Widget build(BuildContext context) {
    final monthData = monthlyExpenses[selectedMonth]!;
    final allowance = monthData['allowance'];
    final expenses = Map<String, int>.from(monthData['expenses']);

    return Scaffold(
      appBar: AppBar(title: const Text('Student Expense Dashboard')),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Text(
                'Student Dashboard',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Dashboard'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Student Profiles'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilesPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final cards = [
            _monthCard(allowance),
            _expenseCard(expenses),
          ];

          return Padding(
            padding: const EdgeInsets.all(16),
            child: constraints.maxWidth < 600
                ? Column(
                    children: [
                      Expanded(child: cards[0]),
                      const SizedBox(height: 16),
                      Expanded(flex: 2, child: cards[1]),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(child: cards[0]),
                      const SizedBox(width: 16),
                      Expanded(flex: 2, child: cards[1]),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _monthCard(int allowance) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: selectedMonth,
              isExpanded: true,
              items: monthlyExpenses.keys.map((month) {
                return DropdownMenuItem(value: month, child: Text(month));
              }).toList(),
              onChanged: (month) {
                if (month != null) {
                  setState(() => selectedMonth = month);
                }
              },
            ),
            const SizedBox(height: 24),
            const Text('Allowance'),
            const SizedBox(height: 8),
            Text(
              '₱$allowance',
              style: const TextStyle(
                fontSize: 32,
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _expenseCard(Map<String, int> expenses) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Expense Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  child: const Text('See All'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ExpensesPage(month: selectedMonth),
                      ),
                    );
                  },
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView.separated(
                itemCount: expenses.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final expense = expenses.entries.elementAt(index);
                  return ListTile(
                    leading: CircleAvatar(child: Text(expense.key[0])),
                    title: Text(expense.key),
                    trailing: Text('₱${expense.value}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpensesPage extends StatelessWidget {
  final String month;

  const ExpensesPage({super.key, required this.month});

  @override
  Widget build(BuildContext context) {
    final expenses = Map<String, int>.from(monthlyExpenses[month]!['expenses']);

    return Scaffold(
      appBar: AppBar(title: Text('$month Expenses')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: expenses.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final expense = expenses.entries.elementAt(index);
          return ListTile(
            tileColor: Colors.indigo.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            leading: CircleAvatar(child: Text(expense.key[0])),
            title: Text(expense.key),
            trailing: Text(
              '₱${expense.value}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}

class ProfilesPage extends StatelessWidget {
  const ProfilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Profiles')),
      body: ListView.separated(
        itemCount: students.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final student = students[index];
          return ListTile(
            leading: ProfileAvatar(student: student),
            title: Text(student['name']),
            subtitle: Text(student['course']),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileDetailsPage(student: student),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProfileDetailsPage extends StatelessWidget {
  final Map<String, dynamic> student;

  const ProfileDetailsPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    final expenses = Map<String, int>.from(student['expenses']);

    return Scaffold(
      appBar: AppBar(title: Text(student['name'])),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: ProfileAvatar(student: student, radius: 42),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              student['name'],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          Text('Course: ${student['course']}'),
          const SizedBox(height: 8),
          Text('Email: ${student['email']}'),
          const SizedBox(height: 8),
          Text('Phone: ${student['phone']}'),
          const SizedBox(height: 8),
          Text('Address: ${student['address']}'),
          const SizedBox(height: 24),
          const Text('Personal Expenses',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Divider(),
          ...expenses.entries.map(
            (expense) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(expense.key),
              trailing: Text('₱${expense.value}'),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  final Map<String, dynamic> student;
  final double radius;

  const ProfileAvatar({super.key, required this.student, this.radius = 20});

  @override
  Widget build(BuildContext context) {
    final imageText = embeddedAvatarImages[student['imageKey']]!;

    return CircleAvatar(
      radius: radius,
      backgroundImage: MemoryImage(base64Decode(imageText)),
    );
  }
}
