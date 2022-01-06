import 'package:flutter/material.dart';

popup(BuildContext context, String alerttext) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Alert"),
            content: Text(alerttext),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context), child: Text("OK"))
            ],
          ));
}
