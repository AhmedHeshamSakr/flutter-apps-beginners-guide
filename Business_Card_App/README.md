# Business Card Application 

<img width="956" alt="Screenshot 2025-06-30 at 10 40 40 AM" src="https://github.com/user-attachments/assets/ea90dc75-cf0d-4037-875c-e50794d90f1b" />

<img width="953" alt="Screenshot 2025-06-30 at 10 41 31 AM" src="https://github.com/user-attachments/assets/624857c8-9766-4daf-b6ef-7e9c6872b7de" />

## Overview
A Flutter-based mobile app designed to simplify the creation, management, and sharing of digital business cards. The application integrates Firebase Authentication for secure user login and Firebase Firestore for reliable storage and retrieval of card data, providing an intuitive user interface for designing personalized business cards.

## Objectives
- **Firebase Integration**: Learn to set up Firebase Authentication and Firestore for secure and scalable backend operations
- **Form Validation**: Implement comprehensive input validation for creating/editing cards (email, phone number, etc.)
- **Dynamic UI Design**: Build responsive and visually appealing interfaces using Flutter widgets
- **State Management**: Use Flutter's state management techniques for seamless functionality
- **Cloud Database**: Understand NoSQL database operations with Firestore

## Key Features

### 1. Secure Authentication System
- **Firebase Authentication**: Email and password-based user registration and login
- **User Session Management**: Secure user sessions with automatic logout
- **Account Creation**: New user registration with validation
- **Error Handling**: Clear error messages for authentication failures

### 2. Personalized Card Creation
- **Input Fields**: Name, job title, company name, contact information
- **Profile Pictures**: Support for user profile images
- **Real-time Updates**: Dynamic card preview as users input information
- **Data Validation**: Comprehensive input validation and error handling

### 3. Interactive Business Card Viewer
- **Dynamic Display**: Cards retrieved from Firebase Firestore in real-time
- **Engaging Format**: Visually appealing card presentation
- **Edit Functionality**: Inline editing of existing cards
- **Responsive Design**: Optimized for different screen sizes

### 4. Cloud Data Management
- **Firebase Firestore**: Real-time database for storing card information
- **User-specific Data**: Cards linked to authenticated user accounts
- **CRUD Operations**: Create, Read, Update, Delete operations for cards
- **Data Synchronization**: Real-time sync across devices

## Technologies Used
- **Flutter SDK**: Cross-platform mobile development
- **Firebase Authentication**: User authentication and security
- **Firebase Firestore**: NoSQL cloud database
- **Dart**: Programming language
- **Material Design**: UI/UX components
- **Cloud Storage**: For profile image storage

## Firebase Configuration
```yaml
dependencies:
  firebase_core: ^2.x.x
  firebase_auth: ^4.x.x
  cloud_firestore: ^4.x.x
  firebase_storage: ^11.x.x
```

## Database Structure
```
users (collection)
├── {userId} (document)
    ├── email: string
    ├── createdAt: timestamp
    └── cards (subcollection)
        ├── {cardId} (document)
            ├── name: string
            ├── jobTitle: string
            ├── company: string
            ├── contactInfo: string
            ├── profilePictureUrl: string
            ├── userId: string
            └── createdAt: timestamp
```


## Implementation Highlights

### Authentication Service
```dart
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      return result.user;
    } catch (e) {
      throw e;
    }
  }
}
```

### Card Management
```dart
Future<void> addCard(String userId, String name, String jobTitle, 
                    String company, String contactInfo) async {
  CollectionReference cards = FirebaseFirestore.instance.collection('cards');
  await cards.add({
    'userId': userId,
    'name': name,
    'jobTitle': jobTitle,
    'company': company,
    'contactInfo': contactInfo,
    'createdAt': FieldValue.serverTimestamp(),
  });
}
```


## Key Features Breakdown

### User Authentication Flow
1. **Sign Up**: New users create accounts with email/password
2. **Login**: Existing users authenticate with credentials
3. **Session Management**: Automatic login persistence
4. **Logout**: Secure session termination

### Card Management Flow
1. **Create Card**: Fill form with personal/professional information
2. **View Cards**: Browse all personal business cards
3. **Edit Card**: Update existing card information
4. **Delete Card**: Remove unwanted cards

## Data Validation Rules
- **Name**: Required, non-empty string
- **Email**: Valid email format validation
- **Phone**: Valid phone number format
- **Job Title**: Optional, string input
- **Company**: Optional, string input

## Security Features
- **User Authentication**: Firebase Authentication security
- **Data Privacy**: User-specific data access only
- **Input Sanitization**: Prevent SQL injection and XSS
- **Secure API Calls**: Encrypted communication with Firebase

## How to Run
1. **Prerequisites**: Flutter SDK, Firebase account
2. **Firebase Setup**:
   - Create Firebase project
   - Enable Authentication (Email/Password)
   - Set up Firestore database
   - Download `google-services.json` (Android) or `GoogleService-Info.plist` (iOS)
3. **Installation**:
   ```bash
   flutter pub get
   flutter run
   ```

## Learning Outcomes
- Firebase integration and cloud database management
- User authentication and session handling
- Real-time data synchronization
- Form validation and error handling
- NoSQL database design and operations
