import 'package:expensetracker/models/expensemodel.dart';
import 'package:expensetracker/models/utils.dart';
import 'package:expensetracker/services/expenseservice.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseController extends GetxController {
  final ExpenseService _expenseService = ExpenseService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

 final  RxList<Expense> expenses = <Expense>[].obs;
Future<void> fetchExpenses(String userId) async {
    try {
      final QuerySnapshot querysnapshot = await _firestore
          .collection('expenses')
          .where('userId', isEqualTo: userId)
          .get();
      final List<Expense> fetchedExpenses = querysnapshot.docs
          .map((doc) => Expense.fromMap(doc.data()))
          .toList()
          .cast();
      expenses.assignAll(fetchedExpenses);
     // expenses.value = fetchedExpenses;
    } catch (error) {
      print('Error fetching expenses: $error');
      Utils.showSnackBar(error.toString());
    }
  }

  Future<void> loadExpenses() async {
    final fetchedExpenses = await _expenseService.getExpenses();
    expenses.value = fetchedExpenses;
  }
  @override
  void onInit() {
    super.onInit();
    loadExpenses();
  }

  

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
