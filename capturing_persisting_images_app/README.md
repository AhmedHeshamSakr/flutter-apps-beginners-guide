# Capturing and Persisting Images Application

<img width="1008" alt="Screenshot 2025-06-30 at 10 46 59 AM" src="https://github.com/user-attachments/assets/2b183b9b-5916-4006-8cfb-b968d9a7370d" />

## Overview
A Flutter application that allows users to capture images using their device's camera and ensures the captured images are displayed within the app, even after restarting. The app leverages Flutter's powerful libraries to integrate device features, manage permissions, and persist data locally, providing a seamless and reliable user experience.

## Objectives
- **Camera Integration**: Learn to integrate device camera functionality with Flutter
- **Permission Management**: Handle camera permissions securely using permission_handler
- **Data Persistence**: Implement local data storage using SharedPreferences
- **Image Handling**: Work with image_picker package for capturing and displaying images
- **State Management**: Manage app state and handle asynchronous operations effectively

## Key Features

### 1. Camera Permissions Management
- **Permission Handling**: Uses `permission_handler` package for camera access
- **User Prompts**: Secure permission requests with clear messaging
- **Settings Navigation**: Direct users to app settings for permission management
- **Permission States**: Handle granted, denied, and permanently denied states

### 2. Image Capture Functionality
- **Camera Integration**: Direct camera access using `image_picker` package
- **Real-time Capture**: Take photos directly within the app
- **Image Quality**: High-quality image capture and processing
- **Error Handling**: Robust error handling for camera failures

### 3. Data Persistence
- **SharedPreferences**: Local storage for image paths
- **App Restart Persistence**: Images remain visible after app closure/restart
- **Path Management**: Secure storage and retrieval of image file paths
- **Data Integrity**: Ensure image availability across app sessions

### 4. Responsive User Interface
- **Adaptive Design**: Responsive UI that adapts to different screen sizes
- **Visual Feedback**: Clear indicators for image capture states
- **Intuitive Layout**: User-friendly interface with clear action buttons
- **Image Display**: Professional image presentation with borders and styling

### 5. State Management
- **Asynchronous Operations**: Efficient handling of async camera and storage operations
- **UI Updates**: Real-time UI updates based on app state changes
- **Loading States**: Proper loading indicators during operations
- **Error States**: Clear error messaging for failed operations

## Technologies Used
- **Flutter SDK**: Cross-platform mobile development framework
- **image_picker**: Camera and gallery image selection
- **shared_preferences**: Local data persistence
- **permission_handler**: Device permission management
- **Dart**: Programming language
- **File I/O**: Local file system operations

## Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  image_picker: ^1.0.4
  shared_preferences: ^2.2.2
  permission_handler: ^11.0.1
```

## Core Implementation

### Permission Management
```dart
Future<void> _captureImage() async {
  final status = await Permission.camera.request();
  
  if (status.isGranted) {
    // Proceed with image capture
  } else if (status.isDenied) {
    // Show permission denied message
  } else if (status.isPermanentlyDenied) {
    // Direct to settings
    openAppSettings();
  }
}
```

### Image Capture Process
```dart
Future<void> _captureImage() async {
  final picker = ImagePicker();
  final image = await picker.pickImage(source: ImageSource.camera);
  
  if (image != null) {
    setState(() {
      _imagePath = image.path;
    });
    
    // Save to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('imagePath', image.path);
  }
}
```

### Data Persistence
```dart
Future<void> _loadImagePath() async {
  final prefs = await SharedPreferences.getInstance();
  setState(() {
    _imagePath = prefs.getString('imagePath');
  });
}
```

## User Interface Components

### Main Screen Layout
- **Image Container**: 400x600 styled container for image display
- **Action Buttons**: "Select Image" and "Capture Image" buttons
- **Placeholder**: Informative placeholder when no image is present
- **Border Styling**: Professional border design for captured images

### Permission Handling UI
- **SnackBar Messages**: Clear permission status communication
- **Settings Action**: Direct link to app settings for permissions
- **Retry Mechanism**: Allow users to retry permission requests

## Permission Flow
1. **Initial Launch**: Check existing camera permissions
2. **Permission Request**: Request camera access when needed
3. **Permission Granted**: Allow camera functionality
4. **Permission Denied**: Show informative message with retry option
5. **Permanently Denied**: Direct user to app settings

## Image Lifecycle
1. **Capture**: User taps "Capture Image" button
2. **Permission Check**: Verify camera permissions
3. **Camera Launch**: Open device camera interface
4. **Image Selection**: User takes photo and confirms
5. **Path Storage**: Save image path to SharedPreferences
6. **Display Update**: Show captured image in app
7. **Persistence**: Image remains visible after app restart


## Platform-Specific Considerations

### Android
- **Permissions**: Camera permission in AndroidManifest.xml
- **File Paths**: Android-specific file system paths
- **Storage Access**: External storage considerations

### iOS
- **Info.plist**: Camera usage description
- **Photo Library**: iOS-specific image handling
- **Permissions**: iOS permission model compliance

## How to Run
1. **Prerequisites**: Flutter SDK installed
2. **Clone Repository**: Download project files
3. **Install Dependencies**: 
   ```bash
   flutter pub get
   ```
4. **Platform Setup**:
   - **Android**: Add camera permission to AndroidManifest.xml
   - **iOS**: Add camera usage description to Info.plist
5. **Run Application**:
   ```bash
   flutter run
   ```

## Testing Scenarios
- **Fresh Install**: Test permission flow on new installation
- **Permission Denial**: Test app behavior when permissions denied
- **App Restart**: Verify image persistence after restart
- **Camera Failure**: Test error handling when camera unavailable
- **Storage Full**: Test behavior when device storage is full

## Learning Outcomes
- Understanding device permission management in Flutter
- Implementing camera functionality in mobile apps
- Working with local data persistence mechanisms
- Handling asynchronous operations and state management
- Creating responsive and user-friendly interfaces
- Error handling and user experience optimization

## Future Enhancements
- **Gallery Selection**: Add option to select images from gallery
- **Multiple Images**: Support capturing and storing multiple images
- **Image Editing**: Basic image editing functionality
- **Cloud Storage**: Upload images to cloud storage
- **Image Compression**: Optimize image sizes for storage

## License
This project is for educational purposes as part of the Mobile Programming course.
