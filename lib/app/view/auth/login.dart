import 'package:chatbuddy/app/controller/auth/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chatbuddy/app/widget/custom_textfield.dart';
import 'package:chatbuddy/app/routes/screen_export.dart';
import 'package:chatbuddy/app/common/toast_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        final loginProvider = Provider.of<LoginProvider>(context, listen: false);
        await loginProvider.login(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
        Navigator.pushReplacementNamed(context, homeScreenRoute);
      } catch (e) {
        showToastMessage(message: e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    controller: _emailController,
                    hintText: 'Enter your email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextField(
                    controller: _passwordController,
                    hintText: 'Enter your password',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shadowColor: Colors.black,
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _login,
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, siginScreenRoute),
                  child: const Text(
                    'Don\'t have an account?',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
