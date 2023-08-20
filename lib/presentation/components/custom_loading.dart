import 'package:flutter/material.dart';

class CustLoading extends StatelessWidget {
  final double size;
  Color? color;
  CustLoading({super.key, required this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        color: color ?? Colors.white,
      ),
    );
  }
}
