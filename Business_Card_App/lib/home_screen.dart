import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'card_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Navigator.of(context).pushReplacementNamed('/login');
      return const Scaffold();
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'My Business Cards',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Log Out',
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            tooltip: 'Add New Card',
            onPressed: () => _showAddCardDialog(context),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal[300]!, Colors.teal[100]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('cards')
              .where('userId', isEqualTo: user.uid)
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  'No business cards found.',
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              );
            }

            final cards = snapshot.data!.docs;

            return ListView.builder(
              itemCount: cards.length,
              itemBuilder: (context, index) {
                final cardDoc = cards[index];
                final cardData = cardDoc.data() as Map<String, dynamic>;
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: cardData['profilePictureUrl'] != null
                        ? CircleAvatar(
                      backgroundImage: NetworkImage(cardData['profilePictureUrl']),
                      radius: 25,
                    )
                        : CircleAvatar(
                      backgroundColor: Colors.teal[100],
                      radius: 25,
                      child: const Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(
                      cardData['name'] ?? 'No Name',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${cardData['jobTitle'] ?? 'No Title'} at ${cardData['company'] ?? 'No Company'}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                    trailing: const Icon(Icons.edit, color: Colors.teal),
                    onTap: () => _showEditCardDialog(context, cardDoc.id, cardData),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showAddCardDialog(BuildContext context) {
    final nameController = TextEditingController();
    final jobTitleController = TextEditingController();
    final companyController = TextEditingController();
    final contactInfoController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Card'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: jobTitleController,
                  decoration: const InputDecoration(labelText: 'Job Title'),
                ),
                TextField(
                  controller: companyController,
                  decoration: const InputDecoration(labelText: 'Company'),
                ),
                TextField(
                  controller: contactInfoController,
                  decoration: const InputDecoration(labelText: 'Contact Info'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  addCard(
                    user.uid,
                    nameController.text,
                    jobTitleController.text,
                    companyController.text,
                    contactInfoController.text,
                  ).then((_) {
                    Navigator.of(context).pop();
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error adding card: $error')),
                    );
                  });
                }
              },
              child: const Text('Add Card'),
            ),
          ],
        );
      },
    );
  }

  void _showEditCardDialog(BuildContext context, String cardId, Map<String, dynamic> cardData) {
    final nameController = TextEditingController(text: cardData['name']);
    final jobTitleController = TextEditingController(text: cardData['jobTitle']);
    final companyController = TextEditingController(text: cardData['company']);
    final contactInfoController = TextEditingController(text: cardData['contactInfo']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Card'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: jobTitleController,
                  decoration: const InputDecoration(labelText: 'Job Title'),
                ),
                TextField(
                  controller: companyController,
                  decoration: const InputDecoration(labelText: 'Company'),
                ),
                TextField(
                  controller: contactInfoController,
                  decoration: const InputDecoration(labelText: 'Contact Info'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance.collection('cards').doc(cardId).update({
                  'name': nameController.text,
                  'jobTitle': jobTitleController.text,
                  'company': companyController.text,
                  'contactInfo': contactInfoController.text,
                }).then((_) {
                  Navigator.of(context).pop();
                }).catchError((error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error updating card: $error')),
                  );
                });
              },
              child: const Text('Update Card'),
            ),
          ],
        );
      },
    );
  }
}
