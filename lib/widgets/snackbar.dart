import 'package:flutter/material.dart';
import 'package:my_app/constants.dart' as constants;

showSnackBar(BuildContext context, String message, int duration) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: constants.purple,
      content: Text(message, textAlign: TextAlign.left),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: duration),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        },
        textColor: constants.white,
      ),
    ),
  );
}
