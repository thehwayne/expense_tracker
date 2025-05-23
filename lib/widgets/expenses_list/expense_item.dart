import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

// This widget displays a single expense entry inside a card
class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense; // The expense data to display

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          children: [
            // Meant for the title of the expense
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 4),
            Row(
              children: [
                // This shows the expense amount with 2 decimal places
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                
                // This spacer is meant to push the date and icon to the right
                const Spacer(),

                // And this displays the category icon and formatted date
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8),
                    Text(expense.formattedDate),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
