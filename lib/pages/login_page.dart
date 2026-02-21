import 'package:flutter/material.dart';
import 'package:pchat/components/auth_services.dart';
import 'package:pchat/components/my_button.dart';

import '../components/my_text_field.dart';

class LoginPage extends StatelessWidget {
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  final emailController = TextEditingController();
  final pwController = TextEditingController();
  void login(BuildContext context) async {
    // auth services
    final authServices = AuthServices();
    try {
      await authServices.signInWithEmailPassword(
        emailController.text,
        pwController.text,
      );
    } catch (e) {
      if(!context.mounted) return;
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text("Login Error ........${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo here
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 10),
            // welcome back
            Text(
              "Welcome back hey buddy' ",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            // email text_field
            MyTextField(
              hintText: "Email here..",
              obscureText: false,
              controller: emailController,
            ),
            const SizedBox(height: 10),
            // password text_field
            MyTextField(
              hintText: "Password here..",
              obscureText: true,
              controller: pwController,
            ),
            const SizedBox(height: 10),
            // login button
            MyButton(text: "Login", onTap: () => login(context)),
            // register now
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Register now",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
