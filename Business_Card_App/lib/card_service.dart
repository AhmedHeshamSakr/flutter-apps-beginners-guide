// services/card_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addCard(
    String userId,
    String name,
    String jobTitle,
    String company,
    String contactInfo,
    ) async {
  try {
    // Get a reference to the Firestore collection
    CollectionReference cards = FirebaseFirestore.instance.collection('cards');

    // Add the card document to the Firestore collection
    await cards.add({
      'userId': userId,
      'name': name,
      'jobTitle': jobTitle,
      'company': company,
      'contactInfo': contactInfo,
      'createdAt': FieldValue.serverTimestamp(), // Timestamp for sorting
    });

    print('Card added successfully');
  } catch (e) {
    print('Error adding card: $e');
    throw e; // Optionally, handle the error as needed
  }
}
