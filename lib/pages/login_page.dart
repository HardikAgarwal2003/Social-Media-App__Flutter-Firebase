import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter_firebase/components/my_button.dart';
import 'package:social_media_app_flutter_firebase/components/my_text_field.dart';
import 'package:social_media_app_flutter_firebase/helper/helper_functions.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  void loginUser() {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    // try sign in

    try {
      // login user
      FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // pop loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop loading circle
      Navigator.pop(context);

      // show error message to user
      showMessageToUser(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
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
                  Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
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
    );
  }
}
