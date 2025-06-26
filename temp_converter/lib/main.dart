import 'package:flutter/material.dart';

void main() {
  runApp(const TempConverterApp());
}

class TempConverterApp extends StatelessWidget {
  const TempConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      home: const TemperatureConverterScreen(),
    );
  }
}

class TemperatureConverterScreen extends StatefulWidget {
  const TemperatureConverterScreen({super.key});

  @override
  State<TemperatureConverterScreen> createState() =>
      _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState
    extends State<TemperatureConverterScreen> {
  String _fromUnit = 'Celsius'; // Default from unit
  String _toUnit = 'Fahrenheit'; // Default to unit
  double? _inputTemperature;
  double? _convertedTemperature;
  String _displayImage = 'assets/?.png';

  final Map<String, String> _unitIcons = {
    'Celsius': 'assets/C.png',
    'Fahrenheit': 'assets/F.png',
    'Kelvin': 'assets/K.png',
  };

  final List<String> _units = ['Celsius', 'Fahrenheit', 'Kelvin'];

  final TextEditingController _tempController = TextEditingController();

  void _convertTemperature() {
    setState(() {
      // Check if the text field is empty or contains an invalid number
      if (_tempController.text.isEmpty || double.tryParse(_tempController.text) == null) {
        // If invalid, do nothing and return
        return;
      }

      double inputTemp = double.parse(_tempController.text); // Input is now guaranteed to be valid

      if (_fromUnit == 'Celsius' && _toUnit == 'Fahrenheit') {
        _convertedTemperature = (inputTemp * 9 / 5) + 32;
      } else if (_fromUnit == 'Celsius' && _toUnit == 'Kelvin') {
        _convertedTemperature = inputTemp + 273.15;
      } else if (_fromUnit == 'Fahrenheit' && _toUnit == 'Celsius') {
        _convertedTemperature = (inputTemp - 32) * 5 / 9;
      } else if (_fromUnit == 'Fahrenheit' && _toUnit == 'Kelvin') {
        _convertedTemperature = (inputTemp + 459.67) * 5 / 9;
      } else if (_fromUnit == 'Kelvin' && _toUnit == 'Celsius') {
        _convertedTemperature = inputTemp - 273.15;
      } else if (_fromUnit == 'Kelvin' && _toUnit == 'Fahrenheit') {
        _convertedTemperature = (inputTemp * 9 / 5) - 459.67;
      } else {
        _convertedTemperature = inputTemp;
      }

      _displayImage = _unitIcons[_toUnit]!;
    });
  }


  void _reset() {
    setState(() {
      _tempController.clear();
      _convertedTemperature = null;
      _displayImage = 'assets/?.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TempConverter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // "From" Dropdown
            DropdownButton<String>(
              value: _fromUnit,
              items: _units.map((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _fromUnit = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            // Temperature input field
            TextField(
              controller: _tempController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Temperature',
              ),
            ),
            const SizedBox(height: 20),
            // "To" Dropdown (moved here)
            DropdownButton<String>(
              value: _toUnit,
              items: _units.map((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _toUnit = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            // Display converted temperature
            _convertedTemperature != null
                ? Column(
              children: [
                const Text(
                  'Converted Temperature:',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10), // Space between the label and the box
                Container(
                  padding: const EdgeInsets.all(16.0), // Padding inside the box
                  decoration: BoxDecoration(
                    color: Colors.purple[50], // Light background color
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                    border: Border.all(
                      color: Colors.purpleAccent, // Border color
                      width: 2.0, // Border width
                    ),
                  ),
                  child: Text(
                    '${_convertedTemperature!.toStringAsFixed(2)} $_toUnit',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple, // Text color
                    ),
                  ),
                ),
              ],
            )
                : Container(),

            const SizedBox(height: 20),
            // Display unit icon
            _convertedTemperature != null ? Image.asset(
              _displayImage,
              width: 100,
              height: 100,
            )
                : Container(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _reset,
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
