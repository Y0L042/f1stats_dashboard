// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart'; // Import firebase_core
import 'dart:convert';
import 'dart:math' as math;

// Import pages
import 'package:f1_dashboard/pages/constructorPage.dart';
import 'package:f1_dashboard/pages/login_page.dart';
import 'package:f1_dashboard/pages/dashboard.dart';
import 'package:f1_dashboard/pages/user_profile_page.dart';
import 'package:f1_dashboard/pages/something_went_wrong.dart';
import 'package:f1_dashboard/pages/loading.dart';


String renderServerURL = 'https://f1stats-flask-server.onrender.com';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure widgets binding
  runApp(F1StatsApp());
}

class F1StatsApp extends StatefulWidget {
  @override
  _F1StatsAppState createState() => _F1StatsAppState();
}

class _F1StatsAppState extends State<F1StatsApp> {
  bool isLoggedIn = false; // Assume the user is not logged in initially
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(); // Initialize Firebase

  @override
  void initState() {
    super.initState();
    checkLoggedInStatus();
  }

  Future<void> checkLoggedInStatus() async {
    // TODO: Implement your login status check logic here
    // For example, you can check if the user has a valid token or session
    // and update the 'isLoggedIn' variable accordingly.
    // You can use SharedPreferences, secure storage, or any other method to store and retrieve the login status.
    // Example:
    // isLoggedIn = await checkIfUserIsLoggedIn();
    isLoggedIn = true; // Assume the user is logged in for demonstration purposes
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Replace your MaterialApp with FutureBuilder
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'F1 Stats App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            // Define the routes and link them to the respective Dart files
            initialRoute: isLoggedIn ? '/dashboard' : '/',
            routes: {
              '/': (context) => LoginPage(),
              '/dashboard': (context) => Dashboard(),
              '/profile': (context) => UserProfilePage(),
            },
          );
        }

        if (snapshot.hasError) {
          return SomethingWentWrong(); // You need to define this widget
        }

        return Loading(); // You need to define this widget
      },
    );
  }
}
