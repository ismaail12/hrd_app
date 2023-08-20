// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrd_app/bloc/auth/auth_bloc.dart';
import 'package:hrd_app/presentation/components/custom_loading.dart';
import 'package:hrd_app/presentation/components/custom_textfield.dart';
import 'package:hrd_app/presentation/screen/app_screen.dart';
import 'package:hrd_app/utils/custom_utils.dart';
import 'package:hrd_app/utils/default_colors.dart';

import '../components/custom_button.dart';

class ChangeProfile extends StatelessWidget {
  ChangeProfile({super.key});
  final nameKey = GlobalKey<CusTextFieldState>();
  final contactKey = GlobalKey<CusTextFieldState>();
  final emailKey = GlobalKey<CusTextFieldState>();
  final addressKey = GlobalKey<CusTextFieldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, // Ganti dengan warna yang diinginkan
        ),
        centerTitle: true,
        title: const Text(
          'Ubah Profil',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                bottom: 16 * 5, left: 16, right: 16, top: 0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 16 * 3),
                  CusTextField(
                    key: nameKey,
                    name: 'Nama Lengkap',
                  ),
                  const SizedBox(height: 16),
                  CusTextField(
                    key: emailKey,
                    name: 'Email',
                  ),
                  const SizedBox(height: 16),
                  CusTextField(
                    key: contactKey,
                    name: 'Kontak ',
                  ),
                  const SizedBox(height: 16),
                  CusTextField(
                    key: addressKey,
                    name: 'Alamat ',
                  ),
                  const SizedBox(height: 16 * 1.5),
                  CusElevatedButton(text: const Text('Simpan'), action: () {}),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
