# Temperature Converter App 
<img width="929" alt="Screenshot 2025-06-30 at 10 29 14 AM" src="https://github.com/user-attachments/assets/350202e3-eb12-451a-bb0a-1719889cd5df" />

## Overview
A Flutter-based mobile application designed to convert temperatures between different units (Celsius, Fahrenheit, and Kelvin) based on user input. This exercise aims to teach fundamental skills in Flutter development.

## Objectives
- **Apply Dart Programming Skills**: Utilize Dart programming and Flutter widgets to create a functioning mobile app
- **User Input Handling**: Understand the concept of user input, processing data, and displaying output
- **Dynamic UI Implementation**: Implement app features such as drop-down menus, text fields, and dynamic results based on user interaction
- **Design Principles**: Practice design principles ensuring usability and clear instructions within the app

## Key Features

### 1. Drop-down Menu Selection
- Allow users to select conversion type (e.g., Celsius to Fahrenheit, Fahrenheit to Kelvin)
- Support for three temperature units: Celsius, Fahrenheit, and Kelvin

### 2. Text Input Field
- User-friendly input field for entering temperature values
- Numeric keyboard for easy data entry
- Input validation to ensure proper temperature values

### 3. Output Display
- Clean container design to display converted temperature values
- Real-time conversion results
- Formatted output with appropriate decimal places

### 4. Dynamic Content
- Context-aware icons displayed based on conversion type
- Visual indicators for different temperature units (C, F, K icons)
- Interactive feedback for user actions

### 5. Reset Functionality
- One-click reset button to clear input field and output
- Reset display images and conversion results
- Start fresh conversion easily

## Technologies Used
- **Flutter SDK**: Cross-platform mobile development framework
- **Dart**: Programming language for Flutter development
- **Material Design**: UI/UX design principles and components
- **StatefulWidget**: For managing app state and dynamic content

## Implementation Details

### Core Conversion Logic
- **Celsius to Fahrenheit**: `(°C × 9/5) + 32 = °F`
- **Celsius to Kelvin**: `°C + 273.15 = K`
- **Fahrenheit to Celsius**: `(°F - 32) × 5/9 = °C`
- **Fahrenheit to Kelvin**: `(°F + 459.67) × 5/9 = K`
- **Kelvin to Celsius**: `K - 273.15 = °C`
- **Kelvin to Fahrenheit**: `(K × 9/5) - 459.67 = °F`

### UI Components
- **DropdownButton**: For unit selection
- **TextField**: For temperature input with numeric keyboard
- **ElevatedButton**: For convert and reset actions
- **Container**: For styled output display
- **Image.asset**: For dynamic unit icons

### State Management
- Uses `StatefulWidget` for reactive UI updates
- `TextEditingController` for input field management
- Dynamic image switching based on target unit

## How to Run
1. Ensure Flutter SDK is installed on your system
2. Clone this repository
3. Navigate to the project directory
4. Run `flutter pub get` to install dependencies
5. Run `flutter run` to launch the app on your connected device/emulator

## Learning Outcomes
- Understanding Flutter widget tree and state management
- Implementing user input validation and error handling
- Creating responsive and intuitive mobile interfaces
- Working with dropdown menus and dynamic content
- Managing application state with StatefulWidget

