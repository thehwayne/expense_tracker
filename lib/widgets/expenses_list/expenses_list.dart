import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

// This is for the expenses list class
// It displays a scrollable list of expense items
class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  // The list of expenses to display
  final List<Expense> expenses;               
  // And this is a callback to remove an expense when dismissed
  final Function onRemoveExpense;             
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // This is the number of items in the list
      itemCount: expenses.length,             
      itemBuilder: (ctx, index) => Dismissible(
         // This is a unique key for each item, which is needed for Dismissible
        key: ValueKey(expenses[index]),      
        
        // This is the background shown while swiping to dismiss
        background: Container(
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
          // The color should be a faded red color
          color: Theme.of(context).colorScheme.error.withValues(alpha: .75), 
        ),

        // This handles the removal of the expense when dismissed
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },

        // This displays the individual expense item
        child: ExpenseItem(expense: expenses[index]),
      ),
    );
  }
}