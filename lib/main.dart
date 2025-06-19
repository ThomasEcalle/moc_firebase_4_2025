import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moc_firebase_4_2025/auth_lesson/auth_lesson_screen.dart';
import 'package:moc_firebase_4_2025/firestore_lesson/firestore_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kDebugMode) {
    try {
      final localhost = switch (defaultTargetPlatform) {
        TargetPlatform.android => '10.66.127.62',
        _ => 'localhost',
      };

      FirebaseFirestore.instance.useFirestoreEmulator(localhost, 8080);
      await FirebaseAuth.instance.useAuthEmulator(localhost, 9099);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const AuthLessonScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Log event'),
              onPressed: () {
                FirebaseAnalytics.instance.logEvent(
                  name: 'click_on_toto',
                  parameters: {
                    'ma_key': 42,
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
