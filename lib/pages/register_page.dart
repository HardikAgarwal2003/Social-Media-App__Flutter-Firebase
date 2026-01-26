import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter_firebase/components/my_button.dart';
import 'package:social_media_app_flutter_firebase/components/my_text_field.dart';
import 'package:social_media_app_flutter_firebase/helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  void registerUser() async {
    // show loading bar...
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // make sure password and confirm password matches.
    if (passwordController.text != confirmPasswordController.text) {
      // pop loading circle
      Navigator.pop(context);

      // show error message to user
      showMessageToUser("Password doesn't match!", context);
    } else {
      // try creating the user
      try {
        // create the user
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );

        // pop loading circle
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // pop loading circle
        Navigator.pop(context);

        // show error message to user
        showMessageToUser(e.code, context);
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

                // username textField
                MyTextField(
                  hintText: "Username",
                  obscureText: false,
                  controller: usernameController,
                ),
                const SizedBox(height: 10),

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

                // confirm password textField
                MyTextField(
                  hintText: "Confirm Password",
                  obscureText: true,
                  controller: confirmPasswordController,
                ),
                const SizedBox(height: 25),

                // sign in button
                MyButton(text: "Register", onTap: registerUser),
                const SizedBox(height: 25),

                // don't have an account? Register here
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Have an account "),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login here",
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
