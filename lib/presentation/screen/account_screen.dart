import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hrd_app/bloc/auth/auth_bloc.dart';
import 'package:hrd_app/presentation/screen/change_pass.dart';
import 'package:hrd_app/presentation/screen/change_profile.dart';
import 'package:hrd_app/presentation/screen/login_screen.dart';
import 'package:hrd_app/utils/custom_utils.dart';
import 'package:hrd_app/utils/default_colors.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text("Pengaturan Akun",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            //konfigurasi akun
            const SizedBox(
              height: 16 * 2,
            ),

            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => ChangePassword(),
                    ));
              },
              child: const ListTile(
                leading: Icon(Icons.key, color: kPrimary),
                title: Text('Update Password'),
                trailing: Icon(Icons.navigate_next),
              ),
            ),

            //tentang aplikasi
            InkWell(
              onTap: () {
                showMessageDialog(context,
                    "Aplikasi dibuat untuk memenuhi tugas akhir skripsi Teknik Informatika Universitas Pamulang");
              },
              child: const ListTile(
                leading: Icon(Icons.phone_android, color: kPrimary),
                title: Text('Tentang Aplikasi'),
                trailing: Icon(Icons.navigate_next),
              ),
            ),
            InkWell(
              onTap: () {
                showMessageDialog(context,
                    "Jika ada pertannyaan atau kendala bisa 08994580581");
              },
              child: const ListTile(
                leading: Icon(Icons.chat_bubble, color: kPrimary),
                title: Text('Bantuan'),
                trailing: Icon(Icons.navigate_next),
              ),
            ),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state.status == AuthStatus.onLogin) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen(),
                    ),
                  );
                }
              },
              child: InkWell(
                onTap: () {
                  CustomUtils.customAlertConfirmDialog(
                    context,
                    () {
                      final token = context.read<AuthBloc>().state.token;
                      context.read<AuthBloc>().add(AuthLogout(token!));
                    },
                    title: 'Konfirmasi',
                    message: 'Yakin keluar?',
                  );
                },
                child: ListTile(
                  leading: const Icon(Icons.door_front_door, color: kPrimary),
                  title: Text(
                    'Sign Out',
                    style: TextStyle(color: Colors.red[500]),
                  ),
                  trailing: const Icon(Icons.navigate_next),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showMessageDialog(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
