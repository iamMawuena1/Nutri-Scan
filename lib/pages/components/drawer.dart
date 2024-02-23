import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.75,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xFF860D9A),
            ),
            accountName: const Text("User"),
            accountEmail: const Text("example@gmail.com"),
            currentAccountPicture: InkWell(
              onTap: () {},
              child: const CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: 60,
                ),
              ),
            ),
          ),
          Column(
            children: [
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text(
                  "Home",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () => Navigator.of(context).pop(),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.sunny_snowing),
                title: const Text(
                  "Theme",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: () {},
              ),
              const Divider(),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              "Logout",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () => logout(context),
          ),
        ],
      ),
    );
  }

  void logout(BuildContext context) {
    //Perform logout logic(clearing user data, tokens etc)

    //navigate to login page
    Navigator.pushNamedAndRemoveUntil(
        context, "/login", (Route<dynamic> route) => false);
  }
}
