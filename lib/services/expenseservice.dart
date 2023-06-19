import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetracker/models/expensemodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ExpenseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference expensesCollection =
      FirebaseFirestore.instance.collection('expenses');

  // getExpenses() async {
  //   String userid = FirebaseAuth.instance.currentUser!.uid;
  //   try {
  //     final expenseSnapshot = await FirebaseFirestore.instance
  //         .collection("expenses")
  //         .doc(userid).collection('expenses').doc()
  //         .get();

  //     if (expenseSnapshot.exists) {
  //       final expenseData = expenseSnapshot.data();
  //       if (expenseData != null) {
  //         final expense = Expense(
  //           id: userid,
  //           title: expenseData['title'],
  //           amount: expenseData['amount'],
  //         );
  //         return [expense] as List<Expense>; // Convert to List<Expense>
  //       }
  //     }
  //   } catch (e) {
  //     print('Error retrieving expenses: $e');
  //   }
  //   return <Expense>[]; // Return an empty list of Expense objects
  // }

  Future<List<Expense>> getExpenses() async {
    final querySnapshot = await expensesCollection
        .doc(_auth.currentUser!.uid)
        .collection('expenses')
        .get();
    return querySnapshot.docs
        .map((doc) => Expense(
            id: doc.id, title: doc['title'], amount: doc['amount'].toDouble()))
        .toList();
  }

  Future<void> addExpense(Expense expense) async {
    print("user addexpense is ${_auth.currentUser!.uid}");
    await expensesCollection
        .doc(_auth.currentUser!.uid)
        .collection('expenses')
        .add({
      'id': _auth.currentUser!.uid,
      'title': expense.title,
      'amount': expense.amount,
    });
  }

  Future<void> updateExpense(Expense expense) async {
    await expensesCollection
        .doc(_auth.currentUser!.uid)
        .collection('expenses')
        .doc(expense.id)
        .update({
      'title': expense.title,
      'amount': expense.amount,
    });
  }

  Future<void> deleteExpense(String expenseId) async {
    await expensesCollection
        .doc(_auth.currentUser!.uid)
        .collection('expenses')
        .doc(expenseId)
        .delete();
  }
}
