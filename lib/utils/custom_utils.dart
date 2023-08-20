import 'package:flutter/material.dart';

class CustomUtils {
  static void displaySnackBarGreen(
      BuildContext context, String message, double marginTop) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          Icon(Icons.done, color: Colors.green[300]),
          const SizedBox(width: 16),
          Text(message, style: const TextStyle(color: Colors.black87)),
        ],
      ),
      elevation: 0,
      backgroundColor: Colors.green[100],
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(milliseconds: 2000),
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - marginTop,
          right: 20,
          left: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void displaySnackBarRed(
      BuildContext context, String message, double marginTop) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          Icon(Icons.warning, color: Colors.red[300]),
          const SizedBox(width: 16),
          Text(message, style: const TextStyle(color: Colors.black87))
        ],
      ),
      elevation: 0,
      backgroundColor: Colors.red[100],
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(milliseconds: 2000),
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - marginTop,
          right: 20,
          left: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static customAlertConfirmDialog(BuildContext context, Function action,
      {required String title, required String message}) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () => Navigator.pop(context),
    );
    Widget continueButton = TextButton(
      child: const Text("Ok"),
      onPressed: () {
        action();
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) => alert,
    );
  }
}
