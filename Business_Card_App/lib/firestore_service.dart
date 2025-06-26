// services/firebase_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> initializeDatabase() async {
    await _firestore.collection('businessCards').doc('sampleCard').set({
      'name': 'John Doe',
      'jobTitle': 'Software Engineer',
      'company': 'Tech Corp',
      'contactInfo': 'john.doe@example.com',
      'profilePicture': null,
    });
  }
}
