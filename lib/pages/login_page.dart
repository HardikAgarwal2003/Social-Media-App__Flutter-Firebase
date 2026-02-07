import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter_firebase/components/my_alert_dialog.dart';
import 'package:social_media_app_flutter_firebase/components/my_button.dart';
import 'package:social_media_app_flutter_firebase/components/my_text_field.dart';

import '../helper/helper_functions.dart';
import 'forgot_pw_page.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      MyAlertDialog.showCustomAlertDialog(
        context,
        'Please enter all the details to login!',
      );
      return;
    }

    if (!isValidEmail(emailController.text.trim())) {
      MyAlertDialog.showCustomAlertDialog(
        context,
        'Please enter a valid email address.',
      );
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      if(!mounted) return;
      if (e.code == 'invalid-email') {
        MyAlertDialog.showCustomAlertDialog(
          context,
          'The email address is not valid!',
        );
      } else if (e.code == 'user-not-found') {
        MyAlertDialog.showCustomAlertDialog(
          context,
          'No user found for this email.',
        );
      } else if (e.code == 'wrong-password') {
        MyAlertDialog.showCustomAlertDialog(context, 'Incorrect password.');
      } else if (e.code == 'invalid-credential') {
        MyAlertDialog.showCustomAlertDialog(
          context,
          'Invalid email or password.',
        );
      } else {
        MyAlertDialog.showCustomAlertDialog(
          context,
          e.message ?? 'Something went wrong!',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo
                if (brightness == Brightness.light)
                  SizedBox(
                    height: 250,
                    width: 250,
                    child: Image.asset(
                      "assets/icons/speedygram_icon.png",
                      fit: BoxFit.fill,
                    ),
                  )
                else
                  SizedBox(
                    height: 250,
                    width: 250,
                    child: Image.asset(
                      "assets/icons/speedygram_inverted_icon.png",
                      fit: BoxFit.fill,
                    ),
                  ),

                const SizedBox(height: 20),

                // email textField
                MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController,
                ),
                const SizedBox(height: 10),

                // password textField
                MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController,
                ),
                const SizedBox(height: 10),

                // forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ForgotPasswordPage();
                              },
                            ),
                          );
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),

                // sign in button
                MyButton(text: "Sign In", onTap: loginUser),
                const SizedBox(height: 25),

                // don't have an account? Register here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? "),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register here",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
