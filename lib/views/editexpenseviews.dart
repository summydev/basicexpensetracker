import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expensetracker/controller/expensecontroller.dart';
import 'package:expensetracker/models/expensemodel.dart';

class EditExpenseView extends StatelessWidget {
  // const AddexpenxeView({super.key});

  final ExpenseController expenseController = Get.put(ExpenseController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final Expense expense;
  EditExpenseView({required this.expense});

  @override
  Widget build(BuildContext context) {
    titleController.text = expense.title;
    amountController.text = expense.amount.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final updatedexpense = Expense(
                  id: expense.id,
                  title: titleController.text,
                  amount: double.parse(amountController.text),
                );
                expenseController.updateExpense(updatedexpense);
                Get.back(); // Go back to the expense list view
              },
              child: const Text('update'),
            ),
          ],
        ),
      ),
    );
  }
}
