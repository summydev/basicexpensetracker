import 'package:expensetracker/models/expensemodel.dart';
import 'package:expensetracker/models/utils.dart';
import 'package:expensetracker/services/expenseservice.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await loadExpenses();
  }

  final ExpenseService _expenseService = ExpenseService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> fetchExpenses(String userId) async {
    try {
      final QuerySnapshot querysnapshot = await _firestore
          .collection('expenses')
          .doc(userId)
          .collection('expenses')
          .orderBy('date')
          .get();
      // .where("uid", isEqualTo: userId)
      // .get();
      final List<Expense> fetchedExpenses = querysnapshot.docs
          .map((doc) => Expense.fromMap(doc.data()))
          .toList()
          .cast();
      expenses.assignAll(fetchedExpenses);
      expenses.value = fetchedExpenses;
    } catch (error) {
      print('Error fetching expenses: $error');
      Utils.showSnackBar(error.toString());
    }
  }

  Future<void> loadExpenses() async {
    final fetchedExpenses = await _expenseService.getExpenses();
    expenses.value = fetchedExpenses;
  }

  RxList<Expense> expenses = <Expense>[].obs;
  Future<void> addExpense(Expense expense) async {
    await _expenseService.addExpense(expense);
    await loadExpenses();
  }

  Future<void> updateExpense(Expense expense) async {
    await _expenseService.updateExpense(expense);
    await loadExpenses();
  }

  Future<void> deleteExpense(String expenseId) async {
    await _expenseService.deleteExpense(expenseId);
    await loadExpenses();
  }
}
