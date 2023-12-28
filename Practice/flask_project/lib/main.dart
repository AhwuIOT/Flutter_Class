import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _passengerIdController = TextEditingController();
  TextEditingController _pclassController = TextEditingController();
  // Add controllers for other fields as needed...

  Future<Map<String, dynamic>> sendPredictionRequest() async {
    final url = Uri.parse('http://127.0.0.1:5000/predict');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      "PassengerId": 1987,
      "Pclass": 3,
      "Name": "Sharapova, Ms. Maria",
      "Sex": "female",
      "Age": 24,
      "SibSp": 0,
      "Parch": 0,
      "Ticket": "",
      "Fare": 112.0,
      "Cabin": "",
      "Embarked": "S"
    });

    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send prediction request');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _passengerIdController,
              decoration: InputDecoration(labelText: 'Passenger ID'),
            ),
            TextField(
              controller: _pclassController,
              decoration: InputDecoration(labelText: 'Pclass'),
            ),
            // Add other input fields here...
            ElevatedButton(
              onPressed: () async {
                final prediction = await sendPredictionRequest();
                // Handle the prediction response here...
                print('Prediction: $prediction');
              },
              child: Text('Send Prediction Request'),
            ),
          ],
        ),
      ),
    );
  }
}
