import 'package:expensetracker/models/expensemodel.dart';
import 'package:expensetracker/services/expenseservice.dart';
import 'package:get/get.dart';

class ExpenseController extends GetxController {
  final ExpenseService _expenseService = ExpenseService();
  final expenses = <Expense>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    final fetchedExpenses = await _expenseService.getExpenses();
    expenses.value = fetchedExpenses;
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
