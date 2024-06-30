import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ratailapp/App/Screen/AddBalancePage.dart';
import 'package:ratailapp/App/Screen/CreateTransferPage.dart';
import 'package:ratailapp/App/Screen/DashBoard.dart';
import 'package:ratailapp/App/Screen/DepositPage.dart';
import 'package:ratailapp/App/Screen/HomePage.dart';
import 'package:ratailapp/App/Screen/LogInPage.dart';
import 'package:ratailapp/App/Screen/NavigationBar.dart';
import 'package:ratailapp/App/Screen/OrdersPage.dart';
import 'package:ratailapp/App/Screen/ReceiptPage.dart';
import 'package:ratailapp/App/Screen/TransferDaimodImo.dart';
import 'package:ratailapp/firebase_options.dart';
import 'package:ratailapp/App/AdminPanel/AdminNavigationBarPage.dart';
import 'App/Screen/practice.dart';
import 'Widget/AppEevatedButton.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );

  //const MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Retail App",
      debugShowCheckedModeBanner: false,
      color: Colors.blueAccent,
      theme: ThemeData(primaryColor: Colors.lightBlue),
      darkTheme: ThemeData(primaryColor: Colors.black54),
      themeMode: ThemeMode.dark,
      home: FutureBuilder<User?>(
        future: _getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // or a splash screen
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final user = snapshot.data;
            if (user?.uid == "Tcke8bEnD5ULbLtL4L8rvVmsfNk2") {
              return AdminMainBottomNavBar();
            } else if (user == null) {
              return LogInSreen();
            } else {
              return MainBottomNavBar();
            }
          }
        },
      ),
    );
  }

  Future<User?> _getUser() async {
    return FirebaseAuth.instance.currentUser;
  }
}
