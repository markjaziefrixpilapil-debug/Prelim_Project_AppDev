import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const DashboardScreen(),
      routes: {
        '/expenses': (context) => const ExpensesPage(),
        '/profiles': (context) => const ProfileListPage(),
      },
    );
  }
}

// Sample data structures
final Map<String, Map<String, dynamic>> monthlyExpenses = {
  'July': {
    'receivedAmount': {'allowance': 3200},
    'expenseAmount': {
      'chickenJoo': 350,
      'mineralWater': 280,
      'ballPointPen': 90,
      'transpoTrain': 280,
      'publicTranspo': 900,
    }
  },
  'August': {
    'receivedAmount': {'allowance': 3500},
    'expenseAmount': {
      'chickenJoo': 400,
      'mineralWater': 300,
      'ballPointPen': 100,
      'transpoTrain': 300,
      'publicTranspo': 1000,
    }
  },
  'September': {
    'receivedAmount': {'allowance': 3600},
    'expenseAmount': {
      'chickenJoo': 420,
      'mineralWater': 320,
      'ballPointPen': 110,
      'transpoTrain': 310,
      'publicTranspo': 1050,
    }
  }
};

Future<bool> assetExists(String path) async {
  try {
    await rootBundle.load(path);
    return true;
  } catch (_) {
    return false;
  }
}

final Map<String, Map<String, dynamic>> studentProfiles = {
  'first_member': {
    'fullName': {
      'last_name': 'Santos',
      'first_name': 'Miguel',
      'middle_initial': 'R',
    },
    'course': 'BS Computer Science',
    'contact_info': {
      'email': 'miguel.santos@example.com',
      'phone': '+63 912 345 6789',
    },
    'address': {
      'region': 'NCR',
      'province': 'Metro Manila',
      'city': 'Quezon City',
      'barangay': 'Central',
      'home_address': '123 Sampaguita St.'
    },
    'expenses': {
      'food': 600,
      'transport': 300,
      'supplies': 150,
      'internet': 800,
      'printing': 120,
      'snacks': 200,
      'coffee': 180,
      'tuitionMisc': 500,
      'phoneLoad': 250,
      'laundry': 200,
    }
  },
  'second_member': {
    'fullName': {
      'last_name': 'Garcia',
      'first_name': 'Ana',
      'middle_initial': 'L',
    },
    'course': 'BS Information Technology',
    'contact_info': {
      'email': 'ana.garcia@example.com',
      'phone': '+63 917 111 2222',
    },
    'address': {
      'region': 'CALABARZON',
      'province': 'Laguna',
      'city': 'San Pablo',
      'barangay': 'Mayondon',
      'home_address': '45 Rizal Ave.'
    },
    'expenses': {
      'food': 700,
      'transport': 350,
      'supplies': 120,
      'internet': 900,
      'printing': 100,
      'snacks': 220,
      'coffee': 150,
      'tuitionMisc': 400,
      'phoneLoad': 300,
      'laundry': 180,
    }
  },
  'third_member': {
    'fullName': {
      'last_name': 'Lopez',
      'first_name': 'Ramon',
      'middle_initial': 'V',
    },
    'course': 'BS Electronics',
    'contact_info': {
      'email': 'ramon.lopez@example.com',
      'phone': '+63 918 333 4444',
    },
    'address': {
      'region': 'Bicol',
      'province': 'Albay',
      'city': 'Legazpi',
      'barangay': 'San Roque',
      'home_address': '88 Mayon St.'
    },
    'expenses': {
      'food': 650,
      'transport': 320,
      'supplies': 130,
      'internet': 700,
      'printing': 110,
      'snacks': 210,
      'coffee': 140,
      'tuitionMisc': 450,
      'phoneLoad': 260,
      'laundry': 190,
    }
  },
  'fourth_member': {
    'fullName': {
      'last_name': 'Reyes',
      'first_name': 'Clara',
      'middle_initial': 'M',
    },
    'course': 'BS Nursing',
    'contact_info': {
      'email': 'clara.reyes@example.com',
      'phone': '+63 919 555 6666',
    },
    'address': {
      'region': 'Central Luzon',
      'province': 'Pampanga',
      'city': 'Angeles',
      'barangay': 'Cutud',
      'home_address': '200 Clark Rd.'
    },
    'expenses': {
      'food': 720,
      'transport': 340,
      'supplies': 160,
      'internet': 850,
      'printing': 130,
      'snacks': 230,
      'coffee': 170,
      'tuitionMisc': 480,
      'phoneLoad': 280,
      'laundry': 210,
    }
  },
};

final Map<int, Map<String, dynamic>> drawerContent = {
  0: {
    'leading': Icons.home,
    'title': 'Home',
    'route': null,
  },
  1: {
    'leading': Icons.person,
    'title': 'Profile Pages',
    'route': '/profiles',
  }
};

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final monthKey = monthlyExpenses.keys.first;
    final monthData = monthlyExpenses[monthKey]!;
    final allowance = monthData['receivedAmount']['allowance'];
    final expenseMap = Map<String, int>.from(monthData['expenseAmount']);

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text('Dashboard', style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ),
            ...drawerContent.entries.map((e) {
              return ListTile(
                leading: Icon(e.value['leading'] as IconData),
                title: Text(e.value['title'] as String),
                onTap: () {
                  Navigator.of(context).pop();
                  final route = e.value['route'] as String?;
                  if (route != null) Navigator.of(context).pushNamed(route);
                },
              );
            }).toList(),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(monthKey, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Text('Allowance: ₱$allowance', style: Theme.of(context).textTheme.titleMedium),
                      const Divider(),
                      const SizedBox(height: 8),
                      const Text('Other Months (example):', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      // For now only one month available in the map
                      Expanded(
                        child: ListView(
                          children: monthlyExpenses.keys.map((m) {
                            return ListTile(
                              title: Text(m),
                              subtitle: Text('Allowance: ₱${monthlyExpenses[m]!['receivedAmount']['allowance']}'),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              flex: 3,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Expense details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (_) => ExpensesPage(expenses: expenseMap, month: monthKey)));
                            },
                            child: const Text('See All'),
                          )
                        ],
                      ),
                      const Divider(),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView.separated(
                          itemCount: expenseMap.keys.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final key = expenseMap.keys.elementAt(index);
                            final val = expenseMap[key];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(key, style: const TextStyle(fontSize: 16)),
                                Text('₱$val', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpensesPage extends StatelessWidget {
  final Map<String, int>? expenses;
  final String? month;

  const ExpensesPage({super.key, this.expenses, this.month});

  @override
  Widget build(BuildContext context) {
    final expenseMap = expenses ?? Map<String, int>.from(monthlyExpenses.values.first['expenseAmount']);
    final title = month != null ? '$month Expenses' : 'Expenses';

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.separated(
          itemCount: expenseMap.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final key = expenseMap.keys.elementAt(index);
            final val = expenseMap[key];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.indigo.shade100,
                    child: Text(key[0].toUpperCase(), style: const TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('₱$val', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text(key, style: const TextStyle(fontSize: 14, color: Colors.black87)),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProfileListPage extends StatelessWidget {
  const ProfileListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profiles')),
      body: ListView.separated(
          itemCount: studentProfiles.keys.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final key = studentProfiles.keys.elementAt(index);
          final entry = studentProfiles[key]!;
          final name = '${entry['fullName']['first_name']} ${entry['fullName']['last_name']}';
          final course = entry['course'] ?? '';
          return FutureBuilder<bool>(
            future: assetExists('assets/avatars/$key.jpg'),
            builder: (context, snap) {
              final has = snap.data == true;
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: has
                      ? AssetImage('assets/avatars/$key.jpg') as ImageProvider
                      : NetworkImage('https://i.pravatar.cc/150?img=${index + 3}'),
                ),
                title: Text(name),
                subtitle: Text(course),
                trailing: ElevatedButton(
                  child: const Text('View'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) => StudentProfilePage(id: key)));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class StudentProfilePage extends StatelessWidget {
  final String id;

  const StudentProfilePage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final profile = studentProfiles[id]!;
    final full = profile['fullName'];
    final contact = profile['contact_info'] as Map<String, dynamic>;
    final address = profile['address'] as Map<String, dynamic>;
    final expenses = Map<String, int>.from(profile['expenses']);

    return Scaffold(
      appBar: AppBar(title: Text('${full['first_name']} ${full['last_name']}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: FutureBuilder<bool>(
                future: assetExists('assets/avatars/$id.jpg'),
                builder: (context, snap) {
                  final has = snap.data == true;
                  return CircleAvatar(
                    radius: 48,
                    backgroundImage: has
                        ? AssetImage('assets/avatars/$id.jpg') as ImageProvider
                        : NetworkImage('https://i.pravatar.cc/150?img=9'),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Center(child: Text('${full['first_name']} ${full['middle_initial']}. ${full['last_name']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            const SizedBox(height: 18),
            const Text('Contact', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text('Email: ${contact['email']}'),
            Text('Phone: ${contact['phone']}'),
            const SizedBox(height: 12),
            const Text('Address', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text('${address['home_address']}, ${address['barangay']}, ${address['city']}, ${address['province']}, ${address['region']}'),
            const SizedBox(height: 12),
            const Text('Course', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text(profile['course'] ?? ''),
            const SizedBox(height: 12),
            const Text('Expenses', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            ...expenses.entries.map((e) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(e.key),
                    Text('₱${e.value}', style: const TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              );
            }).toList()
          ],
        ),
      ),
    );
  }
}
