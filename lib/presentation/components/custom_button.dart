import 'package:flutter/material.dart';
import 'package:hrd_app/utils/default_colors.dart';

// ignore: must_be_immutable
class CusElevatedButton extends StatelessWidget {
  final Widget text;
  final Function action;
  Color? color;
  bool isEnable;
  CusElevatedButton(
      {super.key,
      required this.text,
      required this.action,
      this.color = kPrimary,
      this.isEnable = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: color,
            minimumSize: const Size(double.maxFinite, 45)),
        onPressed: () {
          isEnable ? action() : null;
        },
        child: text,
      ),
    );
  }
}
