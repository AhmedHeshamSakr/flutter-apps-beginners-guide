import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class CurrencyRateScreen extends StatefulWidget {
  const CurrencyRateScreen({super.key});

  @override
  _CurrencyRateScreenState createState() => _CurrencyRateScreenState();
}

class _CurrencyRateScreenState extends State<CurrencyRateScreen> {
  Map<String, dynamic>? currencyRates;
  bool isLoading = true;
  DateTime? lastRefreshedTime;

  @override
  void initState() {
    super.initState();
    fetchCurrencyRates();
  }

  Future<void> fetchCurrencyRates() async {
    setState(() {
      isLoading = true;
    });

    const url = 'http://data.fixer.io/api/latest?access_key=c1cc5fe71de933635c51bd4e7152f057';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Parse the timestamp from the JSON response
        final timestamp = data['timestamp'];
        lastRefreshedTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

        setState(() {
          currencyRates = data['rates'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load currency rates');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (kDebugMode) {
        print(e);
      }
    }
  }

  String getFormattedDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Live Currency Rates',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: fetchCurrencyRates,
          ),
        ],
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        children: [
          if (lastRefreshedTime != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'Data Timestamp: ${getFormattedDateTime(lastRefreshedTime!)}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Last Refreshed: ${getFormattedDateTime(DateTime.now())}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: currencyRates?.length ?? 0,
              itemBuilder: (context, index) {
                final currency = currencyRates!.keys.elementAt(index);
                final rate = currencyRates![currency];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: ListTile(
                    title: Text(
                      currency,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Rate: $rate'),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/currencyConversion',
                        arguments: {
                          'currency': currency,
                          'rate': rate,
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}