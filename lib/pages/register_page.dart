import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app_flutter_firebase/components/my_alert_dialog.dart';
import 'package:social_media_app_flutter_firebase/components/my_button.dart';
import 'package:social_media_app_flutter_firebase/components/my_text_field.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  void registerUser() async {
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPController.text.isNotEmpty &&
        usernameController.text.isNotEmpty) {
      // make sure password and confirm password matches.
      if (passwordController.text != confirmPController.text) {
        // show error message to user
        MyAlertDialog.showCustomAlertDialog(
          context,
          "Password doesn't match with confirm password!",
        );
      } else {
        // try creating the user
        try {
          // create the user
          UserCredential? userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                email: emailController.text,
                password: passwordController.text,
              );

          // create a user document and add to firestore
          createUserDocument(userCredential);
        } on FirebaseAuthException catch (e) {
          // to fix the context warning, as alert should not show, if user navigated to some other place until await is loading some content.
          if (!mounted) return;

          // Handling specific FirebaseAuth errors
          if (e.code == 'weak-password') {
            MyAlertDialog.showCustomAlertDialog(
              context,
              'The password provided is too weak!',
            );
          } else if (e.code == 'email-already-in-use') {
            MyAlertDialog.showCustomAlertDialog(
              context,
              'An account already exists for that email!',
            );
          } else if (e.code == 'invalid-email') {
            MyAlertDialog.showCustomAlertDialog(
              context,
              'The email address is not valid!',
            );
          } else {
            MyAlertDialog.showCustomAlertDialog(
              context,
              'Something went wrong: ${e.message}!',
            );
          }
        }
      }
    } else {
      MyAlertDialog.showCustomAlertDialog(
        context,
        'Please enter all the details to register!',
      );
    }
  }

  // create the user document and collect them in cloud firestore
  Future<void> createUserDocument(UserCredential userCredential) async {
    if (userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user?.email)
          .set({
            "email": userCredential.user!.email,
            "username": usernameController.text.trim(),
          });
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
                  controller: confirmPController,
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
