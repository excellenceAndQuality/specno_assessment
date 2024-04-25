import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:roy_specno_assessment/pages/landing_page.dart';
import 'package:roy_specno_assessment/pages/office/add_office.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Specno Roy Assessment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text("Something went wrong..."),
              ),
            );
          } else if (snapshot.hasData) {
            return const LandingPage();
          } else {
            return const Scaffold(
              body: Center(
                child: Text("Please wait..."),
              ),
            );
          }
        },
      ),
    );
  }
}

