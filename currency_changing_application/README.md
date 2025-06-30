# Currency Converter Application

<img width="912" alt="Screenshot 2025-06-30 at 10 36 36 AM" src="https://github.com/user-attachments/assets/190dbfb7-7680-4c1d-b78d-354c6a339dc9" />

## Overview
Get real-time currency exchange rates and seamless conversions with the Currency Converter App! Whether you're a traveler, trader, or anyone dealing with multiple currencies, this app is your perfect companion for quick and accurate conversions. The app fetches live exchange rates and provides instant Euro-to-currency conversions.

## Objectives
- **API Integration**: Learn to integrate external APIs for real-time data fetching
- **HTTP Requests**: Implement HTTP requests using the `http` package
- **JSON Parsing**: Parse and handle JSON responses from currency APIs
- **Navigation**: Implement multi-screen navigation with arguments passing
- **State Management**: Handle loading states and real-time data updates
- **Error Handling**: Implement robust error handling for network operations

## Key Features

### 1. Live Exchange Rates
- **Real-time Data**: Stay updated with current rates for a wide range of currencies
- **Reliable Source**: Data fetched directly from Fixer.io API
- **Comprehensive Coverage**: Support for 170+ world currencies
- **Auto-refresh**: Rates update automatically with refresh functionality

### 2. Instant Conversion
- **Euro Base**: Convert from Euros to any supported currency
- **Simple Input**: Easy numeric input for conversion amounts
- **Real-time Results**: Instant conversion calculations
- **Accurate Rates**: Precise exchange rate calculations

### 3. Timestamped Data
- **Data Freshness**: Know exactly when rates were last refreshed
- **API Timestamp**: Display original API data timestamp
- **Last Refresh**: Show when data was last fetched locally
- **Reliability Indicator**: Ensure decisions based on latest data

### 4. User-Friendly Interface
- **Clean Design**: Navigate effortlessly with intuitive layout
- **Material Design**: Modern Android design principles
- **Responsive UI**: Works seamlessly across different screen sizes
- **Clear Navigation**: Easy movement between screens

### 5. Refresh Functionality
- **Manual Refresh**: Quickly reload latest rates with refresh button
- **Loading Indicators**: Visual feedback during data fetching
- **Error Recovery**: Retry mechanism for failed requests
- **Market Sync**: Stay synchronized with currency market changes

## Technologies Used
- **Flutter SDK**: Cross-platform mobile development
- **HTTP Package**: For API requests and responses
- **JSON Serialization**: Data parsing and manipulation
- **Material Design**: UI/UX components
- **Dart**: Programming language
- **Fixer.io API**: Real-time currency exchange rates

## API Integration

### Fixer.io API
```dart
const String apiUrl = 'http://data.fixer.io/api/latest?access_key=YOUR_API_KEY';
```

### HTTP Request Implementation
```dart
Future<void> fetchCurrencyRates() async {
  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final timestamp = data['timestamp'];
      lastRefreshedTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      currencyRates = data['rates'];
    }
  } catch (e) {
    // Handle error
  }
}
```

## Screen Flow and Navigation

### 1. Home Screen (`/`)
- **Welcome Interface**: App branding and introduction
- **Navigation Button**: "View Live Rates" button to proceed
- **App Logo**: Visual branding with currency icons
- **Clean Layout**: Minimalist design for clear user flow

### 2. Currency Rate Screen (`/currencyRate`)
- **Live Rates List**: Scrollable list of all supported currencies
- **Rate Display**: Current exchange rates against Euro
- **Timestamp Info**: API data timestamp and last refresh time
- **Refresh Button**: Manual refresh functionality in app bar
- **Navigation**: Tap any currency to access conversion

### 3. Currency Conversion Screen (`/currencyConversion`)
- **Target Currency**: Display selected currency for conversion
- **Input Field**: Amount in Euros to convert
- **Convert Button**: Trigger conversion calculation
- **Result Display**: Formatted conversion result
- **Home Navigation**: Return to main app flow


### Conversion Logic
```dart
double convertCurrency(double amount, double rate) {
  return amount * rate;
}

String formatConversion(double euroAmount, double result, String currency) {
  return '${euroAmount.toStringAsFixed(2)} EUR = ${result.toStringAsFixed(5)} $currency';
}
```

## Supported Currencies
The app supports 170+ currencies including:
- **Major Currencies**: USD, GBP, JPY, CHF, CAD, AUD
- **Emerging Markets**: CNY, INR, BRL, RUB, KRW
- **Cryptocurrencies**: BTC, ETH (if supported by API)
- **Regional Currencies**: Multiple African, Asian, and European currencies


## Date/Time Formatting
```dart
String getFormattedDateTime(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
}
```

## How to Run
1. **API Key Setup**: 
   - Sign up at [Fixer.io](https://fixer.io/)
   - Replace `YOUR_API_KEY` with your actual API key
2. **Dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run Application**:
   ```bash
   flutter run
   ```

## Dependencies
```yaml
dependencies:
  http: ^1.1.0
  intl: ^0.18.1
  flutter:
    sdk: flutter
```

## API Rate Limits
- **Free Tier**: 100 requests/month
- **Paid Plans**: Higher request limits available
- **Caching**: Implement local caching to minimize API calls
- **Refresh Strategy**: Smart refresh to optimize API usage

## Learning Outcomes
- Understanding RESTful API integration in Flutter
- Working with HTTP requests and JSON parsing
- Implementing loading states and error handling
- Creating multi-screen navigation with data passing
- Managing asynchronous operations effectively
- Designing user-friendly financial applications

## Future Enhancements
- **Offline Mode**: Cache rates for offline conversion
- **Currency Favorites**: Save frequently used currencies
- **Historical Rates**: Display currency rate trends
- **Multiple Base Currencies**: Support bases other than Euro
- **Rate Alerts**: Notify users of significant rate changes
- **Calculator Mode**: Enhanced calculation features

## Disclaimer
*Exchange rates provided for educational purposes only. For financial decisions, consult official financial institutions.*
