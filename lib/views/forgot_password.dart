import 'package:expensetracker/models/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';


class ForgotPssword extends StatefulWidget {
  const ForgotPssword({super.key});

  @override
  State<ForgotPssword> createState() => _ForgotPsswordState();
}

class _ForgotPsswordState extends State<ForgotPssword> {
    final emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Input your email to\nreset your password',
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(
              height: 30.0,
            ),
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
            TextButton(
           
              onPressed: ForgotPassword,
              child: Text('Send email '),
            ),
          ],
        ),
              ),
    );
  }
  Future ForgotPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Utils.showSnackBar('Password reset email sent');
    } on FirebaseAuthException catch (e) {
      print(e.message);
      Utils.showSnackBar(e.message);
    }
  }
}
