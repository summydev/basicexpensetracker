//import 'package:expensetracker/routes/routes.dart';
import 'package:expensetracker/views/addexpenseview.dart';
import 'package:expensetracker/views/editexpenseviews.dart';
import 'package:expensetracker/views/signin.dart';
import 'package:expensetracker/views/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expensetracker/controller/expensecontroller.dart';

//import 'package:expensetracker/models/expensemodel.dart';
class ExpenseListView extends StatelessWidget {
  // const ExpenseListView({super.key});

  final ExpenseController expenseController = Get.find<ExpenseController>();
  //String? userid = FirebaseAuth.instance.currentUser!.uid;

  void logoutUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.signOut();
      // ignore: unused_local_variable
      String? userid = auth.currentUser!.uid;
      userid = null;
      // Perform any additional actions after successful logout
    } catch (err) {
      print('Error logging out: $err');
    }
    Get.to(SignUpScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            logoutUser();
          },
          child: Icon(Icons.logout,color: Colors.redAccent,),
        ),
        title: const Text('Expense Tracker'),
      ),
      body: Column(
        children: [
          Text('Note: Tap on the expenses list to edit'),
          Text('Note: Long Press on the expenses list to delete'),
          Text('Note: use the \"+\" to add more expenses '),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: expenseController. expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenseController.expenses[index];

                  return ListTile(
                    title: Text(expense.title),
                    subtitle:
                        Text('Amount:\#${expense.amount.toStringAsFixed(2)}'),
                    onTap: () {
                      Get.to(EditExpenseView(expense: expense));
                    },
                    onLongPress: () {
                      expenseController.deleteExpense(expense.id);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddexpenxeView());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
