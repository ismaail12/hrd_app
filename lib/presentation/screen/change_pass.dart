import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrd_app/bloc/user/user_bloc.dart';
import 'package:hrd_app/presentation/components/custom_loading.dart';
import 'package:hrd_app/presentation/components/custom_textfield.dart';
import 'package:hrd_app/utils/custom_utils.dart';

import '../components/custom_button.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});
  final oldPasswordKey = GlobalKey<CusTextFieldState>();
  final newPasswordKey = GlobalKey<CusTextFieldState>();
  final confirmPasswordKey = GlobalKey<CusTextFieldState>();
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
          'Ubah Password',
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
                  const Text(
                    'Password Anda harus minimal 6 karakter dan harus mencakup kombinasi angka, huruf, dan karakter khusus',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16 * 3),
                  CusTextField(
                    key: oldPasswordKey,
                    isObsecure: true,
                    name: 'Password Sekarang',
                  ),
                  const SizedBox(height: 16),
                  CusTextField(
                    key: newPasswordKey,
                    isObsecure: true,
                    name: 'Password Baru',
                  ),
                  const SizedBox(height: 16),
                  CusTextField(
                    key: confirmPasswordKey,
                    isObsecure: true,
                    name: 'Konfirmasi Password Baru ',
                  ),
                  const SizedBox(height: 16 * 1.5),
                  BlocConsumer<UserBloc, UserState>(
                    listener: (context, state) {
                      if (state.status == UserStatus.success) {
                        CustomUtils.displaySnackBarGreen(
                            context, state.message ?? ' ', 100);
                      }
                      if (state.status == UserStatus.error) {
                        CustomUtils.displaySnackBarRed(
                            context, state.message ?? ' ', 100);
                      }
                    },
                    builder: (context, state) {
                      late Widget text;
                      if (state.status == UserStatus.loading) {
                        text = CustLoading(size: 20);
                      } else {
                        text = const Text('Ganti Password');
                      }
                      return CusElevatedButton(
                          text: text,
                          action: () {
                            final oldPassword = oldPasswordKey
                                .currentState?.controller.text
                                .toString();
                            final newPassword = newPasswordKey
                                .currentState?.controller.text
                                .toString();
                            final confirmPassword = confirmPasswordKey
                                .currentState?.controller.text
                                .toString();

                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              context.read<UserBloc>().add(UserChangePass(
                                  newPassword: newPassword!,
                                  confirmPassword: confirmPassword!,
                                  oldPassword: oldPassword!));
                            }
                          });
                    },
                  ),
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
