# Form and Validation App

<img width="873" alt="Screenshot 2025-06-30 at 10 51 14 AM" src="https://github.com/user-attachments/assets/66322951-d5ef-488e-95d2-5fb218575501" />

## Overview
The Form and Validation App is an intuitive Flutter-based application designed to collect and validate user information. This app allows users to input their name, email, phone number, and password, ensuring that each field meets predefined validation criteria. With a focus on user-friendly design, error handling, and responsive feedback, this app enhances the learning experience of form validation in Flutter.

## Objectives
- **Form Validation**: Master comprehensive input validation techniques in Flutter
- **User Experience**: Create intuitive and responsive form interfaces
- **Error Handling**: Implement real-time error messaging and user feedback
- **Input Management**: Work with various input types and validation patterns
- **State Management**: Handle form state and user interactions effectively

## Key Features

### 1. Interactive Input Fields

#### Name Field
- **Validation**: Requires non-empty input
- **User Feedback**: Clear error message for empty submissions
- **Input Type**: Text input with person icon
- **Real-time Validation**: Immediate feedback on form submission

#### Email Field
- **Format Validation**: Enforces valid email format (example@example.com)
- **Regex Pattern**: Uses comprehensive email validation regex
- **Error Messages**: Specific feedback for invalid email formats
- **Input Type**: Email keyboard for better user experience

#### Phone Number Field
- **Length Validation**: Ensures exactly 10 digits
- **Numeric Input**: Only allows numeric characters
- **Format Checking**: Validates proper phone number format
- **Input Restriction**: Numeric keyboard with input filtering

#### Password Field
- **Minimum Length**: Validates minimum 6 characters
- **Security Display**: Obscured text input for privacy
- **Strength Indication**: Clear requirements communication
- **Input Security**: Password-specific input handling

### 2. Validation Mechanisms
- **Real-time Feedback**: Immediate error messages for invalid inputs
- **Form Widget**: Uses Flutter's `Form` and `TextFormField` for efficient validation
- **Validation Triggers**: Validation on form submission
- **Error States**: Visual indication of validation errors

### 3. Form Submission
- **Success Feedback**: Green SnackBar message upon successful validation
- **Validation Check**: Comprehensive form validation before submission
- **User Confirmation**: Clear indication of successful form completion
- **Data Processing**: Simulated form submission process

### 4. Reset Functionality
- **Complete Reset**: Clears all fields and error messages
- **Single Action**: One-button reset for user convenience
- **State Refresh**: Updates UI to remove all error states
- **Fresh Start**: Returns form to initial empty state

## Technologies Used
- **Flutter SDK**: Cross-platform mobile development framework
- **Form Widgets**: Flutter's built-in form validation system
- **TextFormField**: Advanced input fields with validation
- **RegExp**: Regular expressions for pattern validation
- **Material Design**: Modern UI components and design principles

## Implementation Details

### Form Structure
```dart
class FormValidationScreen extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
}
```

### Validation Logic

#### Email Validation
```dart
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email cannot be empty';
  }
  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  if (!emailRegex.hasMatch(value)) {
    return 'Enter a valid email';
  }
  return null;
}
```

#### Phone Validation
```dart
String? validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return 'Phone number cannot be empty';
  }
  if (value.length != 10) {
    return 'Phone number must be exactly 10 digits';
  }
  if (!RegExp(r'^\d+$').hasMatch(value)) {
    return 'Enter a valid phone number';
  }
  return null;
}
```

#### Password Validation
```dart
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password cannot be empty';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  return null;
}
```

## User Interface Components

### Input Field Design
- **Consistent Styling**: Uniform OutlineInputBorder design
- **Icon Integration**: Relevant icons for each field type
- **Label Text**: Clear field identification
- **Hint Text**: Helpful placeholder guidance
- **Error Display**: Red error text below invalid fields

### Button Layout
- **Dual Button Design**: Submit and Reset buttons side by side
- **Visual Hierarchy**: Primary (Submit) and Secondary (Reset) styling
- **Responsive Spacing**: Proper padding and margins
- **Touch Targets**: Appropriate button sizes for mobile interaction

### Form Layout
- **Vertical Scroll**: ListView for longer forms
- **Proper Spacing**: Consistent spacing between elements
- **Title Section**: Clear form purpose communication
- **Responsive Design**: Adapts to different screen sizes

## App Screenshots
<!-- Add your app screenshots here -->
*Screenshots will be added here showing:*
- Initial empty form with all input fields
- Form with valid data entered
- Form showing validation errors for invalid inputs
- Success message after successful form submission
- Reset functionality clearing all fields

## Validation Rules Summary

| Field | Validation Rules | Error Messages |
|-------|-----------------|----------------|
| Name | Non-empty string | "Name cannot be empty" |
| Email | Valid email format | "Email cannot be empty" / "Enter a valid email" |
| Phone | Exactly 10 digits, numeric only | "Phone number cannot be empty" / "Phone number must be exactly 10 digits" / "Enter a valid phone number" |
| Password | Minimum 6 characters | "Password cannot be empty" / "Password must be at least 6 characters long" |

## Form Submission Flow
1. **User Input**: User fills out all form fields
2. **Submit Action**: User taps "Submit" button
3. **Validation Check**: `_formKey.currentState!.validate()` runs
4. **Error Display**: Show validation errors if any fields invalid
5. **Success Action**: Display success SnackBar if all fields valid
6. **Form State**: Maintain form data until reset

## Reset Functionality
```dart
void _resetForm() {
  _formKey.currentState!.reset();           // Reset form validation state
  _nameController.clear();                  // Clear name field
  _emailController.clear();                 // Clear email field
  _phoneController.clear();                 // Clear phone field
  _passwordController.clear();              // Clear password field
  setState(() {});                          // Update UI
}
```

## Error Handling
- **Input Validation**: Comprehensive client-side validation
- **User Feedback**: Clear, specific error messages
- **Visual Indicators**: Red text and border for invalid fields
- **Prevention**: Prevent form submission with invalid data
- **Recovery**: Easy error correction and revalidation

## How to Run
1. **Prerequisites**: Flutter SDK installed and configured
2. **Clone Repository**: Download project files
3. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
4. **Run Application**:
   ```bash
   flutter run
   ```

## Testing Scenarios
- **Valid Data**: Test successful form submission with all valid inputs
- **Empty Fields**: Test validation when fields are left empty
- **Invalid Email**: Test email format validation with invalid formats
- **Short Password**: Test password length validation
- **Invalid Phone**: Test phone number format and length validation
- **Reset Function**: Test complete form reset functionality

## Learning Outcomes
- Understanding Flutter's form validation system
- Implementing comprehensive input validation
- Creating user-friendly error messaging
- Managing form state and user interactions
- Working with regular expressions for pattern matching
- Designing accessible and intuitive form interfaces


## Future Enhancements
- **Server Validation**: Add backend validation integration
- **Password Strength**: Visual password strength indicator
- **Auto-save**: Save form progress automatically
- **Multi-step Forms**: Break complex forms into steps
- **Custom Validation**: More complex validation rules
- **Form Analytics**: Track form completion rates


## License
This project is for educational purposes as part of the Mobile Programming course.
