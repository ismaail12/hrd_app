import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CusTextField extends StatefulWidget {
  final String name;
  double? padding;
  bool? isObsecure;
  CusTextField({super.key, required this.name, this.isObsecure, this.padding});

  @override
  State<CusTextField> createState() => CusTextFieldState();
}

class CusTextFieldState extends State<CusTextField> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.padding ?? 16),
      child: TextFormField(
        validator: (value) => value == null || value.isEmpty
            ? '${widget.name} tidak boleh kosong'
            : null,
        controller: controller,
        obscureText: widget.isObsecure ?? false,
        decoration: InputDecoration(
            errorStyle: TextStyle(color: Colors.red[400]),
            fillColor: Colors.white,
            filled: true,
            hintText: widget.name,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16)),
      ),
    );
  }
}
