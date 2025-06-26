import 'package:flutter/material.dart';

class CurrencyConversionScreen extends StatefulWidget {
  final String currency;
  final double rate;

  const CurrencyConversionScreen({super.key, required this.currency, required this.rate});

  @override
  _CurrencyConversionScreenState createState() =>
      _CurrencyConversionScreenState();
}

class _CurrencyConversionScreenState extends State<CurrencyConversionScreen> {
  final TextEditingController _amountController = TextEditingController();
  double? convertedAmount;

  void convertCurrency() {
    final amount = double.tryParse(_amountController.text);
    if (amount != null) {
      setState(() {
        convertedAmount = amount * widget.rate;
      });
    } else {
      setState(() {
        convertedAmount = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Convert to ${widget.currency}')
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Convert from Euro to ${widget.currency}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount in Euro',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: convertCurrency,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            if (convertedAmount != null)
              Text(
                '${_amountController.text} EUR = $convertedAmount ${widget.currency}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}
