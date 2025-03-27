import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});
  
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses>{
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
          final List<Expense> _registeredExpenses = [
          Expense(
          title: 'Cheeseburger',
          amount: 11.99,
          date: DateTime.now(),
          category: Category.food
        ),
        Expense(
           title: 'Movie Ticket',
          amount: 18.99,
          date: DateTime.now(),
          category: Category.leisure
        ),
        ];
      ),
    );
  }
}

const uuid = Uuid();

enum Category {food, travel, leisure, work}

class Expense{
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category; // leisure Expense(category : 'leisure') 
}



