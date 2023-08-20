  import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> getInternetConnection() async {
  final check = await Connectivity().checkConnectivity();
  return check == ConnectivityResult.mobile || check == ConnectivityResult.wifi;
}
