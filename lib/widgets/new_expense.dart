import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    // TODO: implement createState
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController(); //This is the amountController 
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _titleController,
                  maxLength: 50,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    label: Text('Title'),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextField( // Text field for amount here
                  controller: _amountController, // Linked to the established amountController
                  keyboardType: TextInputType.number, // Optimized for number
                    decoration: InputDecoration(
                      prefixText: '\$ ', //Figured out the prefix to $
                      label: Text('Amount'), // Label for the Amount text field
                    ),
                  ),
                ),
            ],


          ),

          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  print(_titleController.text);
                  print(_amountController.text);
                },
                child: Text('Save Expense'),
              ),

              ElevatedButton( // Cancel button
                onPressed: (){
                  // TODO: implement cancel logic
                  
                },
                child: Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}