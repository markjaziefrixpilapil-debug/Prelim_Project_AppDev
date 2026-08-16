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
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Left Column: Month and Allowance
            Flexible(
              flex: 2,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(monthKey, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      const Text('Allowance', style: TextStyle(fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 8),
                      Text('₱$allowance', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.indigo)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Right Column: Expense Details
            Flexible(
              flex: 3,
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Expense Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/expenses', arguments: {'month': monthKey});
                            },
                            child: const Text('See All'),
                          ),
                        ],
                      ),
                      const Divider(),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView.separated(
                          itemCount: expenseMap.length,
                          separatorBuilder: (_, __) => const Divider(height: 16),
                          itemBuilder: (context, index) {
                            final key = expenseMap.keys.elementAt(index);
                            final val = expenseMap[key];
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(key, style: const TextStyle(fontSize: 14)),
                                Text('₱$val', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.indigo)),
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
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final monthKey = monthlyExpenses.keys.first;
    final monthData = monthlyExpenses[monthKey]!;
    final expenseMap = Map<String, int>.from(monthData['expenseAmount']);

    return Scaffold(
      appBar: AppBar(title: Text('$monthKey Expenses')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Expenses', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Back'),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: expenseMap.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final key = expenseMap.keys.elementAt(index);
                  final val = expenseMap[key];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.indigo,
                          child: Text(
                            key[0].toUpperCase(),
                            style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(key, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        Text('₱$val', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo)),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
