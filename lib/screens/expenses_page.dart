import 'package:flutter/material.dart';

import '../data/student_data.dart';

class ExpensesPage extends StatelessWidget {
  final String month;

  const ExpensesPage({super.key, required this.month});

  @override
  Widget build(BuildContext context) {
    final monthData = monthlyExpenses[month]!;
    final expenses = Map<String, int>.from(monthData['expenseAmount']);

    return Scaffold(
      appBar: AppBar(title: Text('$month Expenses')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: expenses.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final expense = expenses.entries.elementAt(index);

          return ListTile(
            tileColor: Colors.indigo.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: Text(expense.key[0].toUpperCase()),
            ),
            title: Text(expense.key),
            trailing: Text(
              '₱${expense.value}',
              style: const TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}
