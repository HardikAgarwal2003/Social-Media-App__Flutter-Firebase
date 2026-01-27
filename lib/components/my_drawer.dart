import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final Brightness brightness;

  const MyDrawer({super.key, required this.brightness});

  void logoutUser() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // drawer header
          if (brightness == Brightness.light)
            DrawerHeader(
              child: Image.asset(
                "assets/icons/speedygram_icon.png",
              ),
            )
          else
            DrawerHeader(
              child: Image.asset(
                "assets/icons/speedygram_inverted_icon.png",
              ),
            ),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Home tile
                Padding(
                  padding: EdgeInsetsGeometry.only(left: 20),
                  child: ListTile(
                    leading: Icon(
                      Icons.home_rounded,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: const Text("H O M E"),
                    // this is already Home tile
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                // Profile tile
                Padding(
                  padding: EdgeInsetsGeometry.only(left: 20),
                  child: ListTile(
                    leading: Icon(
                      Icons.person_2_rounded,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: const Text("P R O F I L E"),
                    // this is already Home tile
                    onTap: () {
                      // close the drawer
                      Navigator.pop(context);

                      // navigate to profile page
                      Navigator.pushNamed(context, "/profile_page");
                    },
                  ),
                ),

                // Users tile
                Padding(
                  padding: EdgeInsetsGeometry.only(left: 20),
                  child: ListTile(
                    leading: Icon(
                      Icons.people_rounded,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: const Text("U S E R S"),
                    // this is already Home tile
                    onTap: () {
                      // close the drawer
                      Navigator.pop(context);

                      // navigate to users page
                      Navigator.pushNamed(context, "/users_page");
                    },
                  ),
                ),
              ],
            ),
          ),

          // Logout tile
          Padding(
            padding: EdgeInsetsGeometry.only(left: 20, bottom: 30),
            child: ListTile(
              leading: Icon(
                Icons.logout_rounded,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: Text("L O G O U T"),
              // this is already Home tile
              onTap: (){
                // close the drawer
                Navigator.pop(context);

                // logout user
                logoutUser();
              }
            ),
          ),
        ],
      ),
    );
  }
}
