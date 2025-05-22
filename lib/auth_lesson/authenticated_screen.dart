import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticatedScreen extends StatelessWidget {
  const AuthenticatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Tu es authentifié : ${user?.uid}'),
        ElevatedButton(
          child: Text('Déconnexion'),
          onPressed: () => FirebaseAuth.instance.signOut(),
        )
      ],
    );
  }
}
