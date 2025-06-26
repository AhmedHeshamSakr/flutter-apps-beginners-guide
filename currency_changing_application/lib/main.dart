import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'currency_rate_screen.dart';
import 'currency_conversion_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Changing App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/currencyRate': (context) => const CurrencyRateScreen(),
      },
      onGenerateRoute: (settings) {
        // Handle the '/currencyConversion' route with arguments
        if (settings.name == '/currencyConversion') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) => CurrencyConversionScreen(
              currency: args['currency'],
              rate: args['rate'],
            ),
          );
        }
        return null;
      },
    );
  }
}
