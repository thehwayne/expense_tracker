import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

// The main screen that shows the chart and expense list
class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  // This opens the modal to add a new expense
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      // Keeps the modal content clear of system UI areas
      useSafeArea: true,
      // Allows the modal to expand and scroll freely
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addExpense,
      ),
    );
  }

  // This adds a new expense to the list and updates UI
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  // This removes an expense and shows snackbar with undo option
  void _removeExpense(Expense expense) {
    int expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    // The snackbar with undo button to reinsert the removed expense
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense Removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  // List of currently tracked expenses (with 2 examples)
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Cheeseburger',
      amount: 11.99,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: 'Movie Ticket',
      amount: 18.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    // Fallback UI when there are no expenses
    Widget mainContent = const Center(
      child: Text('No Expenses Found. Click + to add'),
    );

    // If there are expenses, show the list
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          // On narrow screens: chart on top, list below
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(child: mainContent),
              ],
            )
          // On wider screens: chart on the left, list on the right
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
