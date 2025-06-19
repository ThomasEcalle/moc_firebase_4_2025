import 'package:cloud_firestore/cloud_firestore.dart';
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
        ),
        ElevatedButton(
          child: Text('Get user by id'),
          onPressed: () => _getUserById(context),
        ),
      ],
    );
  }

  void _getUserById(BuildContext context) async {
    try {
      final userData = await FirebaseFirestore.instance.collection('users').doc('pWjoUBKOjPdAzgkxpwtdPNle0Ujk').get();
      print(userData.data());
    } catch (error) {
      if (error is FirebaseException) {
        print(error.code);
      }
    }
  }
}
