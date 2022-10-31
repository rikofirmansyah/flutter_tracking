import 'package:device_tracking/Screens/Home_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'Screens/Login_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(
    // Replace with actual values
    options: const FirebaseOptions(
      apiKey: "AIzaSyB1JgpN1KMRStp3olSQWsB5wNIJYl0Z2EA",
      appId: "1:687102100040:android:0f4b4afea19de210de8e7d",
      messagingSenderId: "687102100040",
      projectId: "tracking-loc-9ab28",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return GetMaterialApp(
      title: 'Device Tracking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: user == null ? const LoginScreen() : const HomeScreen(),
    );
  }
}
