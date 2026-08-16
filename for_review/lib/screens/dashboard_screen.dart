import 'package:flutter/material.dart';

import '../data/student_data.dart';

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
            }),
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(monthKey, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 8),
                      Text('Allowance: ₱$allowance', style: Theme.of(context).textTheme.titleMedium),
                      const Divider(),
                      const SizedBox(height: 12),
                      const Text('Monthly overview', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      Text('Total monthly budget: ₱$allowance', style: const TextStyle(color: Colors.black87)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              flex: 3,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Expense details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
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
