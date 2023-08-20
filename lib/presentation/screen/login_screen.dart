import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrd_app/bloc/auth/auth_bloc.dart';
import 'package:hrd_app/presentation/components/custom_loading.dart';
import 'package:hrd_app/presentation/components/custom_textfield.dart';
import 'package:hrd_app/presentation/screen/app_screen.dart';
import 'package:hrd_app/utils/custom_utils.dart';

import '../components/custom_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailKey = GlobalKey<CusTextFieldState>();
  final passwordKey = GlobalKey<CusTextFieldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding:
            const EdgeInsets.only(bottom: 16, left: 16, right: 16, top: 16 * 2),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/kaia.png', height: 200),
                const SizedBox(height: 16),
                CusTextField(
                  name: 'Email',
                  key: emailKey,
                ),
                const SizedBox(height: 16),
                CusTextField(
                  key: passwordKey,
                  isObsecure: true,
                  name: 'Password',
                ),
                const SizedBox(height: 16 * 1.5),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state.status != AuthStatus.loading) {
                      if (state.status == AuthStatus.authenticated) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => AppScreen(),
                          ),
                        );
                      }
                      if (state.status == AuthStatus.error) {
                        CustomUtils.displaySnackBarRed(
                            context, state.message.toString(), 100);
                      }
                    }
                  },
                  builder: (context, state) {
                    late Widget text;
                    if (state.status == AuthStatus.loading) {
                      text = CustLoading(size: 20);
                    } else {
                      text = const Text(
                        'Login',
                        style: TextStyle(fontSize: 16),
                      );
                    }
                    return CusElevatedButton(
                      text: text,
                      action: () async {
                        final email =
                            emailKey.currentState?.controller.text.toString();
                        final password = passwordKey
                            .currentState?.controller.text
                            .toString();

                        if (_formKey.currentState!.validate()) {
                          if (state.status != AuthStatus.loading) {
                            context
                                .read<AuthBloc>()
                                .add(AuthLogin(email!, password!));
                          }
                        }
                        FocusScope.of(context).unfocus();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
