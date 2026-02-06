import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? trailing;

  const MyListTile({super.key, required this.title, required this.subtitle, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
          subtitle: Text(
            subtitle,
            style: TextStyle(color: Colors.grey[500]),
          ),
          trailing: trailing == null
              ? null
              : Text(
            trailing!,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
