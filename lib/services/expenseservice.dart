import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/models/expensemodel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExpenseService {
  final CollectionReference expensesCollection =
      FirebaseFirestore.instance.collection('expenses');
  //final userid = FirebaseAuth.instance.currentUser!.uid;

  Future<List<Expense>> getExpenses() async {
    final querySnapshot = await expensesCollection.get();
    return querySnapshot.docs
        .map((doc) => Expense(
            id: doc.id, title: doc['title'], amount: doc['amount'].toDouble()))
        .toList();
  }

  Future<void> addExpense(Expense expense) async {
    await expensesCollection.add({
      'title': expense.title,
      'amount': expense.amount,
    });
  }

  Future<void> updateExpense(Expense expense) async {
    await expensesCollection.doc(expense.id).update({
      'title': expense.title,
      'amount': expense.amount,
    });
  }

  Future<void> deleteExpense(String expenseId) async {
    await expensesCollection.doc(expenseId).delete();
  }
}
