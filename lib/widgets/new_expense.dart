
import 'dart:io';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

// This is a widget for adding a new expense via a modal form
class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  // A callback to send new expense back
  final void Function(Expense expense) onAddExpense; 

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // These are controllers for form fields
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  // States for selected date and category
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  // This disposes of controllers when widget is removed
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // This validates input and sends new expense to parent
  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final isInvalidAmount = enteredAmount == null || enteredAmount <= 0;

    // If any field is invalid, show an alert dialog 
    // (Should be adaptive to different platforms)
    if (_titleController.text.trim().isEmpty ||
        isInvalidAmount ||
        _selectedDate == null) {
      if (Platform.isIOS) {
        showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
            title: const Text('Invalid Input!'),
            content: const Text(
                'Please make sure valid title, amount, date were entered!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Invalid Input!'),
            content: const Text(
                'Please make sure valid title, amount, date were entered!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'),
              ),
            ],
          ),
        );
      }
      return;
    }

    // This creates and submits the expense
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );

    // Close the modal. Pop!
    Navigator.pop(context);
  }

  // This shows a date picker and updates selected date
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
            child: Column(
              children: [
                // This relates to a Responsive layout
                // Use row if wide, otherwise stack vertically
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            label: Text('Title'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                  ),


                // Wide code used to be here. It's still in the code
                // But it's now on the bottom of this code
                // Why? I had a bit of trouble with something, so I placed it there to making working on it easier
                // Anyway, back to the code

                // Or else, a more compact layout for amount and date picker
                if (width < 600)
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? 'Selected Date'
                                  : formatter.format(_selectedDate!),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 20),

                // This is the dropdown for choosing the expense category
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                    const Spacer(),

// From here, it's experimental
// Basically, had this issue. When horizontal, date picker was gone, and save/cancel buttons were duplicated
// Hopefully, this fixes it

                    // This should ensure that the date picker button appears in horizontal mode too
                    if (width >= 600)
                      Row(
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'Selected Date'
                                : formatter.format(_selectedDate!),
                          ),
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month),
                          ),
                        ],
                      ),

                    // These are for the cancel and save buttons 
                    // Experimental fix for the duplicating cancel and save buttons when horizontal
                    // Used a spread operator for that, learned it here: https://dart.dev/language/operators#spread-operators
                    // Probably a better fix out there, but this will do
                    if (width < 600) ...[
                      const SizedBox(width: 12),
                      ElevatedButton(
                        // When pressed, close modal without saving
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        // When pressed, saves expense
                        onPressed: () {
                          print(_titleController.text);
                          print(_amountController.text);
                          _submitExpenseData();
                        },
                        child: const Text('Save Expense'),
                      ),
                    ]
                  ],
                ),

                // If wide, show Save/Cancel in a separate row (prevents overflow)
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save Expense'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}