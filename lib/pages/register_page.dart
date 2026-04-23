import 'package:chatting_app/services/auth/auth_service.dart';
import 'package:chatting_app/components/my_button.dart';
import 'package:chatting_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  // email and password controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context) async {
    // get auth service
    final auth = AuthService();

    // password match ->create user
    if (_pwController.text == _confirmPwController.text) {
      try {
        // 🔥 FIX: register function use karo
        await auth.signUpWithEmailPassword(
          _emailController.text,
          _pwController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(e.toString())),
        );
      }
    }
    //passowrd dont match-> show error to user
    else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text("Password don't match!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      // 🔥 FIX: prevents yellow/black overflow when keyboard opens
      resizeToAvoidBottomInset: true,

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: 50),

              //Welcome back message
              Text(
                "Let's create an Account for you ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),

              SizedBox(height: 50),

              //email textfield
              MyTextField(
                hintText: "Email",
                obsecureText: false,
                controller: _emailController,
              ),

              SizedBox(height: 10),

              //pw textfield
              MyTextField(
                hintText: "Password",
                obsecureText: true,
                controller: _pwController,
              ),

              SizedBox(height: 10),

              //Confirm pw textfield
              MyTextField(
                hintText: "Confirm Paasword",
                obsecureText: true,
                controller: _confirmPwController,
              ),

              SizedBox(height: 10),

              // login button
              MyButton(text: "Register", onTap: () => register(context)),

              SizedBox(height: 50),

              //register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an Accont ? ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      "Login now",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
