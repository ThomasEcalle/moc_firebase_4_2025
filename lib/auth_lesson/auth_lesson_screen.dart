import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moc_firebase_4_2025/auth_lesson/authenticated_screen.dart';
import 'package:moc_firebase_4_2025/auth_lesson/login_form.dart';

class AuthLessonScreen extends StatelessWidget {
  const AuthLessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Auth'),
      ),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          if(user == null) return LoginForm();
          return AuthenticatedScreen();
        },
      ),
    );
  }

  void _signInWithEmailAndPassword(BuildContext context) {
    FirebaseAuth.instance.signInWithEmailAndPassword(email: 'toto', password: 'toto');
  }
}
