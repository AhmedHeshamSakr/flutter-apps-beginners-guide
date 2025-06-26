import 'package:flutter/material.dart';

void main() {
  runApp(const BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  const BMICalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}


class _BMICalculatorState extends State<BMICalculator> {
  String? selectedGender;
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  String controller1 = "";
  String controller2 = "";
  String bmiResult = '';

  double? calculateBMI(double weight, double height) {
    return weight / ((height / 100) * (height / 100));
  }

  String getHealthStatus(double bmi) {
    if (bmi < 16) return 'Severe Thinness';
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }

  void calculateAndDisplayBMI() {
    double height = double.parse(heightController.text);
    double weight = double.parse(weightController.text);
    double bmi = calculateBMI(weight, height)!;
    setState(() {
      bmiResult = 'Your BMI is ${bmi.toStringAsFixed(2)}. Status: ${getHealthStatus(bmi)}';
    });
  }

  void resetFields() {
    heightController.clear();
    weightController.clear();
    setState(() {
      selectedGender = null;
      bmiResult = '';
    });
  }

  Widget genderImage() {
    return selectedGender == 'Male'
        ? Image.asset('assets/male_avatar.png')
        : Image.asset('assets/female_avatar.png');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            DropdownButton<String>(
              value: selectedGender,
              items: <String>['Male', 'Female'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedGender = newValue;
                });
              },
              hint: Text('Select Gender'),
            ),
            if (selectedGender != null) genderImage(),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter your height in cm'),
              onChanged: (var x) {
                controller1 = x;
              },
            ),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter your weight in kg'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateAndDisplayBMI,
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            Text(
              bmiResult,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetFields,
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
