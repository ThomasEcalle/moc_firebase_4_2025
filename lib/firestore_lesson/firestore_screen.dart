import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreScreen extends StatelessWidget {
  const FirestoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore examples'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').orderBy('price').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('OUPS, une erreur est survenue !'),
            );
          }

          final productsDocuments = snapshot.data?.docs;
          if (productsDocuments == null || productsDocuments.isEmpty) {
            return Center(
              child: Text('OUPS, aucun produit !'),
            );
          }

          return ListView.separated(
            itemCount: productsDocuments.length,
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemBuilder: (context, index) {
              final product = productsDocuments[index];
              return ListTile(
                title: Text(product['name']),
                subtitle: Text('${product['price']}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _addToFirestore(context),
      ),
    );
  }

  void _addToFirestore(BuildContext context) async {
    // Add products with generated ID
    final documentReference = await FirebaseFirestore.instance.collection('products').add({
      'name': 'Salut',
      'price': 12,
    });
    //
    // final createdDocument = await documentReference.get();
    // print('Created document with generated ID: ${documentReference.id}');

    // // Set products with specific ID (erase previous data)
    // FirebaseFirestore.instance.collection('products').doc('random').set({
    //   //'name': 'toto',
    //   'address': '17 rue Erard',
    // });

    // // Update products with specific ID (merge previous data)
    // FirebaseFirestore.instance.collection('products').doc('random').update({
    //   //'name': 'toto',
    //   'address': '17 rue Erard !!',
    // });

    // Remove product with ID
    //FirebaseFirestore.instance.collection('products').doc('random').delete();

    // Get product from ID
    // final snapshot = await FirebaseFirestore.instance.collection('products').doc('toto').get();
    // print('Document price: ${snapshot['price']}');
  }
}
