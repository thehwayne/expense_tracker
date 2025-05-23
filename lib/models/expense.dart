import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// This is a unique ID generator for each expense
const uuid = Uuid();

// Formatter for dates
final formatter = DateFormat.yMd();

// Enum for expense categories
enum Category {
  food, 
  travel,
  leisure,
  work
}

// Mapping each category to a representative icon for UI display
const categoryIcons = {
  Category.food : Icons.lunch_dining,
  Category.travel : Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work : Icons.work
};

// Expense Class
class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category
  }) : id = uuid.v4(); 

  final String id;           
  final String title;        
  final double amount;       
  final DateTime date;       
  final Category category;   

  // Getter for dates
  String get formattedDate {
    return formatter.format(date);
  }
}


// Class for ExpenseBucket, can group multiple expenses in one category
class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses
  });


// Named constructor
  ExpenseBucket.forCategory(
    List<Expense> allExpenses, this.category
  ) : expenses = allExpenses.where((expense) =>
      expense.category == category
    ).toList();

  final Category category;       
  final List<Expense> expenses;  

  // This should calculate the total cost of all expenses in the bucket
  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}

//"This is a bucket."
//"Dear god."
//"There's more."
//"No..."