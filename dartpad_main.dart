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

const Map<String, String> embeddedAvatarImages = {
  'first_member':
      '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',
  'second_member':
      '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',
  'third_member':
      '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',
  'fourth_member':
      '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',
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
