import 'package:flutter/material.dart';

import '../data/student_data.dart';

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
          final name =
              '${entry['fullName']['first_name']} ${entry['fullName']['last_name']}';
          final course = entry['course'] ?? '';
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/avatars/$key.png'),
            ),
            title: Text(name),
            subtitle: Text(course),
            trailing: ElevatedButton(
              child: const Text('View'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => StudentProfilePage(id: key)));
              },
            ),
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
              child: CircleAvatar(
                radius: 48,
                backgroundImage: AssetImage('assets/avatars/$id.png'),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                '${full['first_name']} ${full['middle_initial']}. ${full['last_name']}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 18),
            const Text('Contact',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text('Email: ${contact['email']}'),
            Text('Phone: ${contact['phone']}'),
            const SizedBox(height: 12),
            const Text('Address',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text(
                '${address['home_address']}, ${address['barangay']}, ${address['city']}, ${address['province']}, ${address['region']}'),
            const SizedBox(height: 12),
            const Text('Course',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text(profile['course'] ?? ''),
            const SizedBox(height: 12),
            const Text('Expenses',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            ...expenses.entries.map((e) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(e.key),
                    Text('₱${e.value}',
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
