import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 160.0,
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              "Hey 😊",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "Let's search your grocery food",
              style: TextStyle(color: Colors.white),
            ),
            trailing: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                'https://cdn-icons-png.flaticon.com/128/3135/3135715.png',
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.green,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(160.0); // Match the toolbarHeight
}
