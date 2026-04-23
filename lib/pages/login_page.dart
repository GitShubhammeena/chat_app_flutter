import 'package:chatting_app/components/my_button.dart';
import 'package:chatting_app/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  bool isLoading = false;

  // login method
  void login(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    try {
      final email = _emailController.text.trim();
      final password = _pwController.text.trim();

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print("Login Success");
    } on FirebaseAuthException catch (e) {
      print("Auth Error: ${e.message}");
    } catch (e) {
      print("General Error: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  void handleLogin() {
    // 🔥 FIX: keyboard focus issue
    FocusScope.of(context).unfocus();

    final email = _emailController.text.trim();
    final password = _pwController.text.trim();

    print("Email: $email");
    print("Password: $password");

    if (email.isEmpty || password.isEmpty) {
      print("Fields empty");
      return;
    }

    login(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 50),

            // welcome text
            Text(
              "Welcome back, you've been missed!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 50),

            // email
            MyTextField(
              hintText: "Email",
              obsecureText: false,
              controller: _emailController,
            ),

            const SizedBox(height: 10),

            // password
            MyTextField(
              hintText: "Password",
              obsecureText: true,
              controller: _pwController,
            ),

            const SizedBox(height: 10),

            // login button
            MyButton(
              text: isLoading ? "Loading..." : "Login",
              onTap: handleLogin,
            ),

            const SizedBox(height: 50),

            // register
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
                  onTap: widget.onTap,
                  child: const Text(
                    "Register now",
                    style: TextStyle(fontWeight: FontWeight.bold),
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
