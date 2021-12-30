import 'package:flutter/material.dart';

loader(BuildContext context) {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()));
}
