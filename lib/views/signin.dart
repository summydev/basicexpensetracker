import 'package:email_validator/email_validator.dart';
import 'package:expensetracker/models/utils.dart';
import 'package:expensetracker/views/expenselistview.dart';
import 'package:expensetracker/views/forgot_password.dart';
import 'package:expensetracker/views/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:expensetracker/controller/expensecontroller.dart';
// import 'package:expensetracker/models/expensemodel.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ExpenseController expenseController = Get.put(ExpenseController());

  @override
  Widget build(BuildContext context) {
    Future<void> signIn() async {
      try {
        await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );

        // Retrieve the user's expenses
        await expenseController.fetchExpenses(_auth.currentUser!.uid);
        await expenseController.loadExpenses();
        //navigate to the next screen
        Get.to(ExpenseListView());
        print('User signed in successfully!');
      } on FirebaseAuthException catch (error) {
        print('Error signing in: $error');
        Utils.showSnackBar(error.message);
      }

      @override
      void dispose() {
        // TODO: implement dispose
        emailController.dispose();
        passwordController.dispose();
        super.dispose();
      }
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? 'Enter a valid email'
                      : null,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) => value != null && value.length < 6
                  ? 'Enter a min. of 6 characters'
                  : null,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: signIn,
              child: Text('Sign In'),
            ),
            SizedBox(height: 0.5),
            GestureDetector(
              onTap: () {
                Get.to(ForgotPssword());
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(fontSize: 14.0, color: Colors.blue),
              ),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Get.to(SignUpScreen());
              },
              child: Text('Don\'t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
